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
