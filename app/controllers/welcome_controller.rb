class WelcomeController < ApplicationController
  before_action :check_time_task, :only => [:index]

  def index
    @tasks = Task.where("state == ?", "to_do").last(3)
  end

  private

  def check_time_task
    @tasks = Task.where("end_date <= ? AND state == 'to_do'", DateTime.now)
    @tasks.each do | task|
      if task.state != "confirmed"
        if task.end_date < Date.today
          task.transition_pending
        elsif task.end_date == Date.today && task.hour <= DateTime.now.hour && DateTime.now.minute > 0
          task.transition_pending
        end
      end
    end
  end
end
