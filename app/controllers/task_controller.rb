class TaskController < ApplicationController
  before_action :set_task, :only => [:show, :text_boost, :picture_boost, :money_boost]
  before_action :check_time_task, :only => [:show, :index]
  before_action :check_user

  def index
    @tasks = Task.where("state == ?", "to_do")
    # @tasks = Task.all
  end

  def show
    @boost = Boost.new
  end

  def new
    @task = Task.new
  end

  def category
    @tasks =  Task.where("state == ?", params[:state])
  end


  def text_boost
    @boost = Boost.create(boost_params)
    if @boost.save
      @task.boosts << @boost
      current_user.boosts << @boost
      flash[:notice] = "your boost has been successfully sent"
    else
      flash[:error] = @boost.errors.full_messages.join(', ')
    end
    redirect_to @task
  end

  def picture_boost
    @boost = Boost.create(boost_params)
    if @boost.save
      @task.boosts << @boost
      current_user.boosts << @boost
      flash[:notice] = "your boost has been successfully sent"
    else
      flash[:error] = @boost.errors.full_messages.join(', ')
    end
    redirect_to @task
  end

  def money_boost
    begin
      StripeCard::charge_user(boost_params[:money], "eur", params[:stripeToken])
      @boost = Boost.create(boost_params)
      if @boost.save
        @task.boosts << @boost
        current_user.boosts << @boost
        flash[:notice] = "your boost has been successfully sent"
      else
        flash[:error] = @boost.errors.full_messages.join(', ')
      end
    rescue Exception => e
      flash[:notice] = e.message
    end
    redirect_to @task
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

  def check_time_task
    @tasks = Task.where("end_date <= ?", DateTime.now)
    @tasks.each do | task|
      if task.end_date < Date.today
        task.transition_pending
      elsif task.end_date == Date.today && task.hour < DateTime.now.hour
        task.transition_pending
      end
    end
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :start_date, :end_date, :hour)
  end

  def boost_params
    params.require("boost").permit(:content, :text, :type, :image, :money)
  end

end
