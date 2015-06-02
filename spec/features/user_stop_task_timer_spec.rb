require 'rails_helper'

describe 'UserStopTimer' do 
  let(:user) {FactoryGirl.create(:user)}
  let(:user_2) {FactoryGirl.create(:user)}

  context "user is login" do
    before(:each) do 
      visit task_index_path
      click_link 'Login'
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Log in'
      page.should have_content 'Signed in successfully'
      @task = FactoryGirl.create(:task)
      @task_2 = FactoryGirl.create(:task)
      user.tasks << @task
      user_2.tasks << @task_2
      visit task_path(@task.id)
    end

    it "allows user to stop task timer" do 
      click_link 'Stop Timer'
      page.should have_content("The task has been stop")
      page.should have_content("TIME IS FINISH")
    end

    it "should not allows user to stop task timer" do 
      visit task_path(@task_2.id)
      page.should_not have_content 'Stop Timer'
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
