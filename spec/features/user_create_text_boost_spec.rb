require 'rails_helper'

describe "UserCreateTextBoost" do 
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

    it "should allow user to do an text boost" do 
      fill_in "Type", :with => "TextBoost"
      fill_in "Text", :with => "hello boby keep going you can do it"
      click_button "send Boost"
      page.should have_content "your boost has been successfully sent"
    end

  end
end
