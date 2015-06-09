class WelcomeController < ApplicationController
  before_action :check_time_task, :only => [:index]

  def index
    @tasks = Task.where("state = ?", "ongoing").last(3)
  end

  private

  def check_time_task
    @tasks = Task.where("end_date <= ? AND state = 'ongoing'", DateTime.now)
    @tasks.each do | task|
      if task.state != "successful"
        if task.end_date < Date.today
          task.transition_finished
        elsif task.end_date == Date.today && task.hour <= DateTime.now.hour && DateTime.now.minute > 0
          task.transition_finished
        end
      end
    end
  end
end
