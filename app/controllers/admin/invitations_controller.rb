class Admin::InvitationsController < Devise::InvitationsController
  before_filter :authenticate_inviter!, :only => [:create]

  skip_before_filter :has_invitations_left?, :only => [:create]

  def create
    user = User.find_by_id(params[:id])
    InvitationWorker.perform_async(current_admin.id, user.id)

    flash[:success] = "Invitation to #{user.first_name}#{' '}#{user.last_name} will be sent"
    redirect_to admin_users_path
  end
end
