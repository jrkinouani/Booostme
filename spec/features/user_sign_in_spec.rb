require 'rails_helper'

describe 'UserSignin' do
  let(:user) {FactoryGirl.create(:user)}

  it "should allow a registered user to sign in " do
    visit new_user_session_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Log in'
    page.should have_content 'Welcome'
  end

  it "should not allow user to sign in with invalid password" do 
    visit new_user_session_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => "userpassword"
    click_button 'Log in'
    page.should have_content("Invalid email or password")
  end

  it "should not allow an unregistered user to sign in" do 
    visit new_user_session_path
    fill_in 'Email', :with => "newuser@example.com"
    fill_in 'Password', :with => "userpassword"
    click_button 'Log in'
    page.should have_content("Invalid email or password")
  end

end
