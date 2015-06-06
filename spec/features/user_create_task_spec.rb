require 'rails_helper'

describe 'UserCreateTask' do 
  let(:user) {FactoryGirl.create(:user)}

  context "user is login" do
    before(:each) do 
      visit task_index_path
      click_link 'Login'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Log in'
      page.should have_content 'Signed in successfully'
      click_link 'Create challenge'
    end

    it "allows user to create task" do 
      fill_in 'Title', :with => "task 1"
      fill_in 'End date', :with => Date.today + 6
      attach_file "task_cover_image", "spec/files/booostme_400vert.png"
      click_button 'Create'
      page.should have_content("Task task 1 succefully created")
    end

    it "should not allow user to create task with date of tomorrow" do
      fill_in 'Title', :with => "task 1"
      fill_in 'End date', :with => Date.today - 1
      click_button 'Create'
      page.should have_content("End date must be after or equal to #{Date.today + 1}")
    end

    it "should not allow user to create task with date of 100 day" do
      fill_in 'Title', :with => "task 1"
      fill_in 'End date', :with => Date.today + 99
      click_button 'Create'
      page.should have_content("End date must be before or equal to #{Date.today + 98}")
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

  context "user is not login" do 

    it "should redirect to sign in page when user visit index task page" do 
      visit task_index_path
      page.should have_content("You need to login")
      page.should have_content("Please sign in")
    end

    it "should redirect to sign in page when user visit new task page" do 
      visit new_task_path
      page.should have_content("You need to login")
      page.should have_content("Please sign in")
    end
  end

end
