require 'rails_helper'

describe "UserCreateMoneyBoost" do 
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

    # it "should allow user to do a money boost" do 
    #   fill_in "card_number", :with => "4242424242424242"
    #   fill_in "cvc", :with => "999"
    #   fill_in "exp-month", :with => "9"
    #   fill_in "exp-year", :with => "2018"
    #   choose("boost_money_100")
    #   click_button "send money"
    #   page.should have_content "your boost has been successfully sent"
    #   page.should have_content "by #{user.login}"
    # end
  end

  context "user is not login" do 
    it "should redirect to sign in page when user visit task show" do 
      visit task_path(task.id)
      page.should have_content("You need to login")
      page.should have_content("Please sign in")
    end
  end

end
