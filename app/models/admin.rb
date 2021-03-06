class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable #, :registerable,
  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  include DeviseInvitable::Inviter
end
