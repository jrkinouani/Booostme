require 'rails_helper'

RSpec.describe "task/show.html.erb", type: :view do
  before(:each) do 
    @task = FactoryGirl.build(:task)
    @boost = FactoryGirl.build(:boost)
    user = FactoryGirl.create(:user)
    @task.end_date -= 1
    user.tasks << @task
    assign :task, @task
    render
  end

  it "display title of the task" do 
    rendered.should have_selector('h2', :text => @task.title)
  end

  it "display due date of the task" do 
    rendered.should have_selector('p', :text => "Due date #{@task.end_date}")
  end

  it "display owner og the task" do
    rendered.should have_selector('p', :text => "By #{@task.user.login}")
  end

  it "display Title Boot him" do 
    rendered.should have_selector('h3', :text => "Boost #{@task.user.login} with :")
  end


  it "display a form to create a text boost" do 
    rendered.should have_selector("form[action='/task/#{@task.id}/text_boost']")
  end

  it "display a field to enter a Type" do 
    rendered.should have_selector("form[action='/task/#{@task.id}/text_boost'] input#boost_type")
    rendered.should have_selector("form[action='/task/#{@task.id}/text_boost'] input#boost_type[value='TextBoost']")
  end

  it "display a field to enter a Text" do
    rendered.should have_selector("form[action='/task/#{@task.id}/text_boost']", :text => 'Text' )
    rendered.should have_selector("form[action='/task/#{@task.id}/text_boost'] textarea#boost_text")
  end

end
