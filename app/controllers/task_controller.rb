class TaskController < ApplicationController
  before_action :set_task, :only => [:show]
  before_action :check_user

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.start_date = Date.today
    if @task.save
      flash[:notice] = "Task #{@task.title} succefully created"
      current_user.tasks << @task
      redirect_to @task
    else
      flash[:error] = @task.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def check_user
    if current_user.nil?
      flash[:error] = "You need to login"
      redirect_to new_user_session_path
    end
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :start_date, :end_date)
  end

end
