class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    generated_password = Devise.friendly_token.first(8)
    @user.password = generated_password

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: "#{@user.first_name}#{' '}#{@user.last_name} was successfully created." }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 25).order(:last_name)
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def edit_password
    @user = User.find_by_id(params[:user_id])
    respond_to do |format|
      if @user.invitation_token.present?
          format.html { redirect_to admin_users_path, notice: "You can't reset the password, #{' '}#{@user.first_name}#{' '}#{@user.last_name} has not yet accepted the invitation. You can re-invite the user." }
      else
        format.html { render action: 'edit_password' }
      end
    end
  end

  def update_password
    @user = User.find_by_id(params[:user_id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: "Successfully updated #{@user.first_name}#{' '}#{@user.last_name} password." }
      else
        format.html { render action: 'edit_password' }
      end
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to admin_users_path, notice: "#{@user.first_name}#{' '}#{@user.last_name} was successfully updated." }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @deleted_user = "#{@user.first_name}#{' '}#{@user.last_name}"
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "#{@deleted_user} was successfully deleted." }
    end
  end

  def view_reports
    @user = User.find_by_id(params[:user_id])
    attachments = @user.attachments.order('created_at desc')
    @latest_attachment = attachments.first
    @previous_attachments = attachments.drop(1)
  end

  def download_report
    attachment_record = Attachment.find(params[:id])
    data = open(attachment_record.avatar.expiring_url)
    send_data data.read, filename: attachment_record.avatar_file_name,
                         type: attachment_record.avatar_content_type,
                         disposition: 'attachment',
                         stream: 'true',
                         buffer_size: '4096'
  end

  def destroy_report
    @attachment_record = Attachment.find(params[:id])
    @user = User.find_by_id(@attachment_record.user_id)
    @deleted_attachment_file_name = @attachment_record.file_name
    @attachment_record.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_view_reports_path(:user_id => @attachment_record.user_id), notice: "Successfully deleted #{@deleted_attachment_file_name}." }
    end
  end


  # Method to send the notification
  def send_notification
    user = User.find(params[:user_id])
    user.update_attribute(:notified_at, Time.now)
    NotificationWorker.perform_async(user.id)

    flash[:success] = "Notification to #{user.first_name}#{' '}#{user.last_name} will be sent"
    redirect_to admin_users_path
  end

  def search_user
    search_text = params[:search].strip
    if !search_text.blank?
      @users = User.search_by_full_name(search_text).paginate(:page => params[:page], :per_page => 25).order(:last_name)
    else
      @users = User.paginate(:page => params[:page], :per_page => 25).order(:last_name)
    end
   respond_to do |format|
      format.js
    end
  end

  private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :company, :website, :address, :phone, :password, :password_confirmation, :secret_code)
  end
end
