class Task < ActiveRecord::Base
  belongs_to :user
  validates :start_date, date: {equal_to: Date.today}
  validates :end_date, date: {after: Date.today + 2}
end
