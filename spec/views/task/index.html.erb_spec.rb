require 'rails_helper'

RSpec.describe "task/index.html.erb", type: :view do
  before(:each) do 
    @task = FactoryGirl.build(:task)
    assign :tasks, [@task]
    render
  end

  it "displays list of last task created" do
    rendered.should have_selector('div.col-xs-6.col-lg-3 h2', :text => @task.title)
    rendered.should have_selector('div.col-xs-6.col-lg-3 p', :text => @task.end_date)
  end
end
