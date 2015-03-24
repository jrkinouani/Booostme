require 'rails_helper'

RSpec.describe "task/new.html.erb", type: :view do
  before(:each) do 
    @task = FactoryGirl.build(:task)
    assign :task, @task

    render
  end

  it "display a form to create a task" do 
    rendered.should have_selector("form[action='/task']")
  end

  it "display a field to enter a title" do 
    rendered.should have_selector("form[action='/task'] label", :text => "Title")
    rendered.should have_selector("form[action='/task'] input#task_title")
  end

  it "display a field to enter a end date" do 
    rendered.should have_selector("form[action='/task'] label", :text => "End date")
    rendered.should have_selector("form[action='/task'] input#task_end_date")
  end
end
