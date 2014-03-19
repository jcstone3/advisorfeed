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

  private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :description, :address, :phone, :password, :password_confirmation)
  end
end
