class User < ActiveRecord::Base
  # Relationships
  has_many :attachments, class_name: 'Attachment', foreign_key: 'user_id', dependent: :destroy

  attr_accessor :enable_validation


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable #, :validatable

  validates_presence_of :first_name, :message => "Can't be blank"
  validates_presence_of :last_name, :message => "Can't be blank"
  validates_presence_of :secret_code, :message => "Can't be blank"
  validates_format_of :first_name, :with =>/^[a-z A-Z][a-z A-Z 0-9_]*$/, :allow_blank => true, :message => "Should contain only alphabets", :multiline => true
  validates_format_of :last_name, :with =>/^[a-z A-Z][a-z A-Z 0-9_]*$/, :allow_blank => true, :message => "Should contain only alphabets", :multiline => true

  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of       :password, :within => 6..128, :allow_blank => true

  validates_presence_of :email, :message => "Can't be blank"
  validates_uniqueness_of :email, :case_sensitive => false, :allow_blank => true, :if => :email_changed?, :message=> "Email address already taken"
  validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?, :message => "Invalid email address"

  # custom validation for secret text matching
  validates :secret_code, secret_code: true, :if => :has_user_secret

  validates :terms_of_service, acceptance: true

  include PgSearch
  pg_search_scope :search_by_full_name, :against => [:first_name, :last_name], :using => {:tsearch => {:dictionary => "english",:any_word => true, :prefix => true} }

  def has_user_secret
    return true if enable_validation
  end

  protected
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
