require 'rails_helper'

describe 'UserSearchTaskByCategory' do 
  let(:user) {FactoryGirl.create(:user)}

  context "user is login" do
    before(:each) do 
      visit task_index_path
      click_link 'Login'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Log in'
      page.should have_content 'Signed in successfully'
      @task_1 = FactoryGirl.create(:task)
      @task_2 = FactoryGirl.create(:task)
      user.tasks << @task_2
      @task_2.transition_pending
    end

    it "allows user to search pending task" do 
      click_link 'Pending task'
      page.should have_content(@task_2.title)
      page.should have_content(@task_2.end_date)
    end

    it "allows user to search todo task" do 
      click_link 'Todo task'
      page.should have_content(@task_1.title)
      page.should have_content(@task_1.end_date)
    end

    it "allows user to search Confirmed task" do
      @task_2.transition_confirmed
      click_link 'Confirmed task'
      page.should have_content(@task_2.title)
      page.should have_content(@task_2.end_date)
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
