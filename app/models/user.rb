class User < ActiveRecord::Base
  # Relationships
  has_many :attachments, class_name: 'Attachment', foreign_key: 'user_id', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :message => "Can't be blank"
  validates_presence_of :last_name, :message => "Can't be blank"
end
