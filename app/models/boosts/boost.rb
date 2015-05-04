class Boost < ActiveRecord::Base
  belongs_to :task
  validates :content, length: {maximum: 140}
end
