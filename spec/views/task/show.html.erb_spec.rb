require 'rails_helper'

RSpec.describe "task/show.html.erb", type: :view do
  before(:each) do 
    @task = FactoryGirl.build(:task)
    @boost = FactoryGirl.build(:boost)
    user = FactoryGirl.create(:user)
    user.tasks << @task
    assign :task, @task

    render
  end

  it "display tilte of the task" do 
    rendered.should have_selector('h2', :text => @task.title)
  end

  it "display due date of the task" do 
    rendered.should have_selector('p', :text => "Due date #{@task.end_date}")
  end

  it "display owner og the task" do
    rendered.should have_selector('p', :text => "Owner #{@task.user.login}")
  end

end
