class TaskController < ApplicationController
  before_action :set_task, :only => [:show]

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
      redirect_to @task
    else
      flash[:error] = @task.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :start_date, :end_date)
  end

end
