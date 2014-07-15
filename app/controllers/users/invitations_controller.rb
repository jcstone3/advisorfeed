class Users::InvitationsController < Devise::InvitationsController
  before_filter :configure_permitted_parameters
  prepend_before_filter :require_no_authentication, :only => [:edit, :update]


  def edit
    render :edit
  end

  def update
    resource = user = User.find_by_invitation_token(params[:user][:invitation_token], false)
    user.enable_validation = true
    super
  end

  # private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :secret_text, :invitation_token, :enable_validation, :terms_of_service)
  end

  #this is to include secret text as a field to be validated while accepting invitation

  protected

  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:secret_text, :terms_of_service]
    # Override accepted parameters
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:password, :password_confirmation, :secret_text,
               :invitation_token, :terms_of_service, :enable_validation)
    end
  end


end
