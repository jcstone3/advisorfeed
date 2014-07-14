class Users::InvitationsController < Devise::InvitationsController
  before_filter :configure_permitted_parameters, :set_user, :set_from_invitation
  prepend_before_filter :require_no_authentication, :only => [:edit, :update]
  #prepend_before_filter :resource_from_invitation_token, :only => [:edit]

  def edit
    render :edit
  end

  def update
    super
  end

  # private

  # def user_params
  #   params.require(:user).permit(:password, :password_confirmation, :secret_text, :invitation_token, :terms_of_service)
  # end

  #this is to include secret text as a field to be validated while accepting invitation

  protected

  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:secret_text, :terms_of_service]
    # Override accepted parameters
    devise_parameter_sanitizer.for(:accept_invitation) do |u|
      u.permit(:password, :password_confirmation, :secret_text,
               :invitation_token, :terms_of_service)
    end
  end

  def set_user
    @object = User.find_by_invitation_token(params[:invitation_token], false)
  end
  def set_from_invitation
    @object.from_invitation = true
  end
end
