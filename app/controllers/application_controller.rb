class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  # before_filter :authenticate_user!, unless: proc { |c| c.devise_controller?}

  def authenticate_admin!
    if admin_signed_in?
       admin_users_path
     else
      redirect_to new_admin_session_path :alert => "You must first log in to access this page"
    end
  end

  def authenticate_user!
    if user_signed_in?
       users_dashboard_path
     else
      redirect_to new_user_session_path :alert => "You must first log in to access this page"
    end
  end


  def after_sign_in_path_for(resource)
    if resource.is_a? User
      # flash[:success] = "Welcome! You have signed up successfully."
      users_dashboard_path
    else #resource is an admin
      # flash[:success] = "Welcome! You have signed up successfully."
      admin_users_path
    end
  end

  def after_sign_out_path_for(resource_name)
    if resource_name.is_a? User
      # flash[:success] = "You have signed out successfully."
      new_user_session_path
    else #resource is an admin
      # flash[:success] = "You have signed out successfully."
      new_admin_session_path
    end
  end

  protected

  def configure_permitted_parameters
    # Override accepted parameters
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:invitation_token, :password, :password_confirmation)
    end
  end

  def authenticate_inviter!
    authenticate_admin!
  end
end
