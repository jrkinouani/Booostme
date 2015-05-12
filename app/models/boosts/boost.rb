class Boost < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  validates :text, length: {maximum: 140}
  mount_uploader :image, ImageUploader 

end
