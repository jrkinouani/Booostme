require 'rails_helper'

describe "UserSendImageOfValidationEndTask" do 
  let(:user) {FactoryGirl.create(:user)}
  let(:task) {FactoryGirl.create(:task)}

  context "user is login" do 
    before(:each) do
      task.end_date -= 1
      task.transition_finished
      user.tasks << task
      visit root_path
      click_link 'Login'
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Log in"
      page.should have_content "Signed in successfully"
      visit task_path(task.id)
    end

    it "should allow user to send image to validation task" do 
      user.tasks << task
      attach_file "validation_image", "spec/files/booostme_400vert.png"
      click_button "Upload image"
      page.should have_content "The task has confirmed"
    end
  end

  context "user is not login" do 
    it "should redirect to sign in page when user visit task show" do 
      visit task_path(task.id)
      page.should have_content("You need to login")
      page.should have_content("Please sign in")
    end
  end

end
