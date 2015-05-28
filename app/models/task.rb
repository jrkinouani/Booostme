class Task < ActiveRecord::Base
  belongs_to :user
  has_many :boosts
  validates :title, :start_date, :hour, :end_date, :presence => true
  validates :start_date, date: {equal_to: Date.today}
  validates :end_date, date: {after_or_equal_to: Date.today}

  # state :to_do, initial: :true
  # state :pending
  # state :confirmed

  def time_before_end
    time_in_second = (DateTime.new(end_date.year, end_date.month, end_date.day, hour, 0, 0, '+2') - DateTime.now) * 1.day
    time_in_second > 0 ? time_in_second.to_i : 0
  end

  def transition_pending
    state = "pending"
    self.save
  end

  def transition_confirmed
    state = "confirmed"
    self.save
  end

end
