class Users::DashboardsController < ApplicationController
  require "open-uri"
  before_filter :authenticate_user!

  def index
    @attachments = current_user.attachments
  end

  def download_report
    attachment_record = Attachment.find(params[:id])
    data = open(attachment_record.avatar.url)
    send_data data.read, filename: attachment_record.avatar_file_name,
                         type: attachment_record.avatar_content_type,
                         disposition: 'attachment',
                         stream: 'true',
                         buffer_size: '4096'
  end
end
