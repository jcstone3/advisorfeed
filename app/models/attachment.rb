class Attachment < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  # has_attached_file :avatar #, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    #Add configuration to upload attachments to S3 buckets
  has_attached_file :avatar,
                    storage: :s3,
                    s3_credentials: {
                      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
                      bucket: ENV['S3_BUCKET_NAME']
                      },
                    s3_permissions: :private,
                    url: ENV['HOST'] ,
                    path: "users/:user_id/attachment/:id/:basename.:extension"

  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, content_type: { content_type: "application/pdf" }
end
