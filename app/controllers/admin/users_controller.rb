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
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
      else
        Rails.logger.debug @user.errors.inspect
        format.html { render action: 'new' }
      end
    end
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
      else
        Rails.logger.debug @user.errors.inspect
        format.html { render action: 'edit' }
      end
    end
  end

  def show
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'User was successfully deleted.' }
    end
  end

  def view_reports
    user = User.find_by_id(params[:user_id])
    @attachments = user.attachments
  end

  def download_report
    attachment_record = Attachment.find(params[:id])
    data = open(attachment_record.avatar.url)
    send_data data.read, filename: attachment_record.avatar_file_name,
                         type: attachment_record.avatar_content_type,
                         disposition: 'attachment',
                         stream: 'true',
                         buffer_size: '4096'
  end

  def destroy_report
    @attachment_record = Attachment.find(params[:id])
    @attachment_record.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_view_reports_path(:user_id => @attachment_record.user_id), notice: 'User report successfully deleted.' }
    end
  end

  private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :description, :address, :phone, :password, :password_confirmation)
  end
end
