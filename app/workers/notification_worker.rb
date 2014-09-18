class NotificationWorker

  include Sidekiq::Worker

  sidekiq_options :queue => :notification_worker,
                  :retry => 3,
                  :backtrace => true,
                  :failures => true

  #called by sidekiq to process the job
  def perform(user_id)
    user = User.find_by_id(user_id)
    Usermailer.notification_instructions(user).deliver
  end
end
