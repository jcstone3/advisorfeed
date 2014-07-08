class InvitationWorker

  include Sidekiq::Worker

  sidekiq_options :queue => :invitation_worker,
                  :retry => 3,
                  :backtrace => true,
                  :failures => true

  #called by sidekiq to process the job
  def perform(current_admin_id, user_id)
    admin = Admin.find_by_id(current_admin_id)
    user = User.find_by_id(user_id)
    user.invite!(admin)
  end
end
