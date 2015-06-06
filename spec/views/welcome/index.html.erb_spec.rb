require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  before(:each) do 
    @task = FactoryGirl.build(:task)
    assign :tasks, [@task]
    render
  end

  it "displays a list of last task" do
    rendered.should have_selector('.col-xs-6.col-lg-3 h2', :text => @task.title)
    rendered.should have_selector('.col-xs-6.col-lg-3 p', :text => @task.end_date)
  end

end
