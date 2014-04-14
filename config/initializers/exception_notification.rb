Rails.application.config.middleware.use ExceptionNotification::Rack,
  :email => {
  :email_prefix         => "[AdvisorFeed Exception] ",
  :sender_address       => %{"notifier" <support@advisorfeed.com>},
  :exception_recipients => %w{support.advisor@icicletech.com}
}
