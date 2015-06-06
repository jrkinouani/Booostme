require 'rails_helper'


describe 'UserRegistration' do 
  it 'allows user to register' do
    visit new_user_registration_path
    fill_in 'Login', :with => 'oualid'
    fill_in 'Email', :with => 'newuser@example.com'
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => 'userpassword'
    attach_file "user_avatar", "spec/files/booostme_400vert.png"
    click_button 'Sign up'
    page.should have_content 'Welcome'
  end

  it 'should not allows user to register without login' do 
    visit new_user_registration_path
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => 'userpassword'
    attach_file "user_avatar", "spec/files/booostme_400vert.png"
    click_button 'Sign up'
    page.should have_content("Login can't be blank")
  end


  it 'should not allows user to register with login allready taken' do 
    user = FactoryGirl.create(:user)
    visit new_user_registration_path
    fill_in 'Login', :with => user.login
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => 'userpassword'
    attach_file "user_avatar", "spec/files/booostme_400vert.png"
    click_button 'Sign up'
    page.should have_content("Login has already been taken")
  end

  it 'should not allows user to register with invalid email' do 
    visit new_user_registration_path
    fill_in 'Login', :with => 'oualid'
    fill_in 'Email', :with => 'dfsfdsfsdf'
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => 'userpassword'
    attach_file "user_avatar", "spec/files/booostme_400vert.png"
    click_button 'Sign up'
    page.should have_content('Email is invalid')
  end

  it "should not allows user to register with Password (8 characters minimum)" do 
    visit new_user_registration_path
    fill_in 'Login', :with => 'oualid'
    fill_in 'Email', :with => "newuser@example.com"
    fill_in 'Password', :with => 'oualid'
    fill_in 'Password confirmation', :with => 'oualid'
    attach_file "user_avatar", "spec/files/booostme_400vert.png"
    click_button 'Sign up'
    page.should have_content('Password is too short (minimum is 8 characters)')
  end

  it "should not allows user to register without Password confirmation" do
    visit new_user_registration_path
    fill_in 'Login', :with => 'oualid'
    fill_in 'Email', :with => "newuser@example.com"
    fill_in 'Password', :with => 'userpassword'
    attach_file "user_avatar", "spec/files/booostme_400vert.png"
    click_button 'Sign up'
    page.should have_content("Password confirmation doesn't match")
  end

  it "should not allows user to register when Password confirmation doesn't match" do 
    visit new_user_registration_path
    fill_in 'Login', :with => 'oualid'
    fill_in 'Email', :with => "newuser@example.com"
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => "oualid23"
    attach_file "user_avatar", "spec/files/booostme_400vert.png"
    click_button 'Sign up'
    page.should have_content("Password confirmation doesn't match")
  end

  it 'should not allows user to register without avatar' do
    visit new_user_registration_path
    fill_in 'Login', :with => 'oualid'
    fill_in 'Email', :with => 'newuser@example.com'
    fill_in 'Password', :with => 'userpassword'
    fill_in 'Password confirmation', :with => 'userpassword'
    click_button 'Sign up'
    page.should have_content "Avatar can't be blank"
  end

end
