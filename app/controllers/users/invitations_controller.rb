class Users::InvitationsController < Devise::InvitationsController
  before_filter :authenticate_inviter!, :only => [:invite_resource]

  def create
    Rails.logger.debug "params --------------------------"
    Rails.logger.debug params.inspect
  end

  def update
    # # if this
    # #   redirect_to admin_users_path
    # # else
    # #   super
    # # end
    # Rails.logger.debug "params ------------------------"
    # Rails.logger.debug params.inspect
    # user = User.find_by_invitation_token(update_user[:invitation_token])
    # respond_to do |format|
    #   if user.update(update_user)
    #     format.html { redirect_to new_user_session_path, notice: 'User was updated successfully.' }
    #     format.json { head :no_content }
    #   else
    #     Rails.logger.debug @user.errors.inspect
    #     format.html { render action: 'edit' }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
    self.resource = accept_resource

    if resource.errors.empty?
      yield resource if block_given?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end

  # this is called when creating invitation
  # should return an instance of resource class
  def invite_resource
    ## skip sending emails on invite
    resource_class.invite!(invite_params, current_inviter) do |u|
      u.skip_invitation = true
    end
  end

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
    ## Report accepting invitation to analytics
    # Analytics.report('invite.accept', resource.id)
    resource
  end

  private

  def update_user
    params.require(:user).permit(:invitation_token, :password, :password_confirmation)
  end
end
