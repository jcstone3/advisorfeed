class User < ActiveRecord::Base
  # Relationships
  has_many :attachments, class_name: 'Attachment', foreign_key: 'user_id', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable #, :validatable

  validates_presence_of :first_name, :message => "Can't be blank"
  validates_presence_of :last_name, :message => "Can't be blank"
  validates_presence_of :secret_text, :message => "Can't be blank"
  validates_format_of :first_name, :with =>/^[a-z A-Z][a-z A-Z 0-9_]*$/, :allow_blank => true, :message => "Should contain only alphabets", :multiline => true
  validates_format_of :last_name, :with =>/^[a-z A-Z][a-z A-Z 0-9_]*$/, :allow_blank => true, :message => "Should contain only alphabets", :multiline => true
  # validates_presence_of :password, :presence => true, :message  => "Can't be blank"
  # validates_length_of :password,  :within => 6..30, :message => "Should be greater than 6 and less than 30"

  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of       :password, :within => 6..128, :allow_blank => true

  validates_presence_of :email, :message => "Can't be blank"
  validates_uniqueness_of :email, :case_sensitive => false, :allow_blank => true, :if => :email_changed?, :message=> "Email address already taken"
  validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?, :message => "Invalid email address"

  protected
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

end
