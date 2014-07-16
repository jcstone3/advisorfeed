class Users::DashboardsController < ApplicationController
  require "open-uri"
  before_filter :authenticate_user!

  def index
    @latest_attachment = current_user.attachments.order('created_at desc').first
    @previous_attachments = current_user.attachments.order('created_at desc').drop(1)
  end

  def download_report
    attachment_record = Attachment.find(params[:id])
    data = open(attachment_record.avatar.expiring_url)
    send_data data.read, filename: attachment_record.avatar_file_name,
                         type: attachment_record.avatar_content_type,
                         disposition: 'attachment',
                         stream: 'true',
                         buffer_size: '4096'
  end

  def squash_test
    nil.id
  end
end
