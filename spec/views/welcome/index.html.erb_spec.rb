require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  before(:each) do 
    @task = FactoryGirl.build(:task)
    assign :tasks, [@task]
    render
  end

  it "displays a list of last task" do
    rendered.should have_selector('li h2', :text => @task.title)
    rendered.should have_selector('li p', :text => @task.end_date)
  end

  it "displays link to create task" do 
    rendered.should have_selector('a',
                                  :text => "Create task")
  end

end
