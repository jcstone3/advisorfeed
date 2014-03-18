class Admin::InvitationsController < Devise::InvitationsController
  before_filter :authenticate_inviter!, :only => [:create]

  skip_before_filter :has_invitations_left?, :only => [:create]

  def create
    user = User.find_by_id(params[:id])
    if user.invite!(current_admin)
      flash[:success] = " User invited successfully! "
      redirect_to admin_users_path
    end
  end
end
