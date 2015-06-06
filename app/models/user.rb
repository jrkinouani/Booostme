class User < ActiveRecord::Base
  mount_uploader :avatar, ImageUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :login, :password, :avatar, presence: true
  validates :login, uniqueness: true
  # validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  # validates :password, length: {minimum: 8}
  has_many :tasks
  has_many :boosts

  # validates_presence_of   :avatar
  validates_integrity_of  :avatar
  validates_processing_of :avatar

end
