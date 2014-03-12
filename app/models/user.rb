class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username, :message => "can't be blank"
  # validates_format_of :username, :with =>/^[a-z A-Z][a-z A-Z 0-9_]*$/, :message => "Name should contain only alphabets"
  # validates_presence_of :password, :on => :edit
  # validates :password, presence: true, confirmation: true, if: :password_required?

  # protected
  #  def password_required?
  #       hashed_password.blank? or not password.blank?
  #   end
end
