require 'rails_helper'

describe 'UserCreateTask' do 
  before(:each) do 
    visit task_index_path
    click_link 'Create task'
  end

  it "allows user to create task" do 
    fill_in 'Title', :with => "task 1"
    fill_in 'End date', :with => Date.today + 6
    click_button 'Create'
    page.should have_content("Task task 1 succefully created")
  end

  it "should not allow user to create task without title" do
    fill_in 'End date', :with => Date.today + 6
    click_button 'Create'
    page.should have_content("Title can't be blank")
  end

  it "should not allow user to create task withou end date" do
    fill_in 'Title', :with => "task 1"
    click_button 'Create'
    page.should have_content("End date can't be blank")
  end
end
