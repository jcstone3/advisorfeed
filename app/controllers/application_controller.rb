class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # include Squash::Ruby::ControllerMethods
  # enable_squash_client

  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_httpuser
  # before_filter :authenticate_user! #, unless: proc { |c| c.devise_controller?}

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

  # unless config.consider_all_requests_local
  #   rescue_from Exception, with: :render_500
  #   rescue_from ActionController::RoutingError, with: :render_404
  #   rescue_from ActionController::UnknownController, with: :render_404
  #   # rescue_from ActionController::UnknownAction, with: :render_404
  #   rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # end

  def after_sign_in_path_for(resource)
    if resource.is_a? User
      users_dashboard_path
    else #resource is an admin
      admin_users_path
    end
  end

  def after_sign_out_path_for(resource_name)
    if resource_name == :user #.is_a? User
      new_user_session_path
    else #resource is an admin
      new_admin_session_path
    end
  end

  protected

  def authenticate_httpuser
    if Rails.env.staging?
      authenticate_or_request_with_http_basic do |username, password|
        username == "advisor" && password == "testadvisor"
      end
    end
  end

  def configure_permitted_parameters
    # Override accepted parameters
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:invitation_token, :password, :password_confirmation)
    end
  end

  def authenticate_inviter!
    authenticate_admin!
  end

  # unless config.consider_all_requests_local
  #   rescue_from Exception, with: :render_500
  #   rescue_from ActionController::RoutingError, with: :render_404
  #   rescue_from ActionController::UnknownController, with: :render_404
  #   # rescue_from ActionController::UnknownAction, with: :render_404
  #   rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, :with => :render_error
  end

  def render_error(exception)
    ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver
  end

  #error handling
  def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render file: 'public/404.html', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    @error = exception
    respond_to do |format|
      format.html { render file: 'public/500.html', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end
end
