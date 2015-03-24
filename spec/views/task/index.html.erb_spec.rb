require 'rails_helper'

RSpec.describe "task/index.html.erb", type: :view do
  before(:each) do 
    @task = FactoryGirl.build(:task)
    assign :tasks, [@task]
    render
  end

  it "displays link to create task" do
    rendered.should have_selector('a', :text => 'Create task')
  end

  it "displays list of last task created" do
    rendered.should have_selector('li h2', :text => @task.title)
    rendered.should have_selector('li p', :text => @task.end_date)
  end
end
