#Add Paperclip interpolations for attachments
Paperclip.interpolates :user_id do |attachment, style|
  attachment.instance.user_id
end
