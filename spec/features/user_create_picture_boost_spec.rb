require 'rails_helper'

describe "UserCreatePictureBoost" do 
  let(:user) {FactoryGirl.create(:user)}
  let(:task) {FactoryGirl.create(:task)}

  context "user is login" do 
    before(:each) do
      user.tasks << task
      visit root_path
      click_link 'Login'
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Log in"
      page.should have_content "Signed in successfully"
      visit task_path(task.id)
    end

    it "should allow user to do an picture boost" do
      Capybara.ignore_hidden_elements = false
      attach_file "boost_image", "spec/files/booostme_400vert.png"
      click_button "send Picture"
      page.should have_content "your boost has been successfully sent"
      page.should have_content "by #{user.login}"
      Capybara.ignore_hidden_elements = true
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
