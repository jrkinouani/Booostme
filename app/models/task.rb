class Task < ActiveRecord::Base
  belongs_to :user
  has_many :boosts
  validates :title, :start_date, :end_date, :presence => true
  validates :start_date, date: {equal_to: Date.today}
  validates :end_date, date: {after: Date.today + 2}

  def time_before_end
    (end_date - DateTime.now) * 1.day
  end
end
