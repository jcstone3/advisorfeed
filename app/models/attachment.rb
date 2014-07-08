class Attachment < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  # has_attached_file :avatar #, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    #Add configuration to upload attachments to S3 buckets
  has_attached_file :avatar,
                    storage: :s3,
                    s3_credentials: {
                      access_key_id: Settings.aws_access_key_id,
                      secret_access_key: Settings.aws_secret_access_key,
                      bucket: Settings.s3_bucket_name
                      },
                    s3_permissions: :private,
                    url: Settings.host ,
                    path: "users/:user_id/attachment/:id/:basename.:extension"

  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, content_type: { content_type: "application/pdf" }, :message => "Only pdf format is allowed for attachment"
  # validates_presence_of :file_name, :message => "Can't be blank"
  # validates_presence_of :file_note, :message => "Can't be blank"
  validates_attachment_presence :avatar, :message => "Please attach a file"
end
