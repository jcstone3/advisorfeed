class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :authenticate_admin!

  def new
    @user = User.new
    Rails.logger.debug "new user inspect --------------------------------"
    Rails.logger.debug @user.inspect

  end

 def create
    Rails.logger.debug "params inspect --------------------------------"
    # Rails.logger.debug params[:user].inspect
    # if params[:user][:password].blank?
    #   params[:user].delete(:password)
    #   params[:user].delete(:password_confirmation)
    # end
    # Rails.logger.debug params[:user].inspect
    @user = User.new(user_params)
    generated_password = Devise.friendly_token.first(8)
    @user.password = generated_password
    Rails.logger.debug user_params.inspect
    Rails.logger.debug @user.inspect
    # if @user.password.blank?
    #   Rails.logger.debug "if iiiiiiiiiiiiiiiiii"
    #   @user.delete("password")
    #   @user.delete("password_confirmation")
    # end
    # @user.dont_validate_password
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
    @users = User.all
  end

  def edit

  end

  def show

  end

  def destroy

  end

  private

  def user_params
      params.require(:user).permit(:username, :email, :description, :address, :phone, :password, :password_confirmation)
  end
end
