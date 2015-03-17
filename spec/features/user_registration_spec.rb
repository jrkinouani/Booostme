require 'rails_helper'


describe 'UserRegistration' do 
  it 'allows user to register' do
    visit new_user_registration_path
    fill_in 'First name', :with => 'oualid'
    fill_in 'Last name', :with => 'jouhri'
    fill_in 'Email', :with => 'newuser@example.com'
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => 'userpassword'
    click_button 'Sign up'
    page.should have_content 'Welcome'
  end

  it 'should not allows user without First name' do 
    visit new_user_registration_path
    fill_in 'Last name', :with => 'jouhri'
    fill_in 'Email', :with => 'dfsfdsfsdf'
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => 'userpassword'
    click_button 'Sign up'
    page.should have_content("First name can't be blank")
  end

  it 'should not allows user without Last name' do 
    visit new_user_registration_path
    fill_in 'First name', :with => 'jouhri'
    fill_in 'Email', :with => 'dfsfdsfsdf'
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => 'userpassword'
    click_button 'Sign up'
    page.should have_content("Last name can't be blank")
  end

  it 'should not allows user with invalid email' do 
    visit new_user_registration_path
    fill_in 'First name', :with => 'oualid'
    fill_in 'Last name', :with => 'jouhri'
    fill_in 'Email', :with => 'dfsfdsfsdf'
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => 'userpassword'
    click_button 'Sign up'
    page.should have_content('Email is invalid')
  end

  it "should not allows user with Password (8 characters minimum)" do 
    visit new_user_registration_path
    fill_in 'First name', :with => 'oualid'
    fill_in 'Last name', :with => 'jouhri'
    fill_in 'Email', :with => "newuser@example.com"
    fill_in 'Password', :with => 'oualid'
    fill_in 'Password confirmation', :with => 'oualid'
    click_button 'Sign up'
    page.should have_content('Password is too short (minimum is 8 characters)')
  end

  it "should not allows user without Password confirmation" do
    visit new_user_registration_path
    fill_in 'First name', :with => 'oualid'
    fill_in 'Last name', :with => 'jouhri'
    fill_in 'Email', :with => "newuser@example.com"
    fill_in 'Password', :with => 'userpassword'
    click_button 'Sign up'
    page.should have_content("Password confirmation doesn't match")
  end

  it "should not allows user when Password confirmation doesn't match" do 
    visit new_user_registration_path
    fill_in 'First name', :with => 'oualid'
    fill_in 'Last name', :with => 'jouhri'
    fill_in 'Email', :with => "newuser@example.com"
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => "oualid23"
    click_button 'Sign up'
    page.should have_content("Password confirmation doesn't match")
  end

end
