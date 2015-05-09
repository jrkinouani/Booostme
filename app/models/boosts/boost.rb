class Boost < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  validates :content, length: {maximum: 140}
end
