class Task < ActiveRecord::Base
  belongs_to :user
  validates :title, :start_date, :end_date, :presence => true
  validates :start_date, date: {equal_to: Date.today}
  validates :end_date, date: {after: Date.today + 2}
end
