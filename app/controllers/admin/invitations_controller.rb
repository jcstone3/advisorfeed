class Admin::InvitationsController < Devise::InvitationsController
  before_filter :authenticate_inviter!, :only => [:create]

  skip_before_filter :has_invitations_left?, :only => [:create]

  def create
    user = User.find_by_id(params[:id])
<<<<<<< HEAD
    InvitationWorker.perform_async(current_admin.id, user.id)
    flash[:success] = "#{user.first_name}#{' '}#{user.last_name} invited successfully! "
=======
    #admin = Admin.find_by_id(current_admin_id)
    #user = User.find_by_id(user_id)
    user.invite!(current_admin)

    flash[:success] = "Invitation to #{user.first_name}#{' '}#{user.last_name} will be sent"
>>>>>>> e1b1eeb... [Secret Text] Fixed invitation form issue
    redirect_to admin_users_path
  end
end
