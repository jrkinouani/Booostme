require 'rails_helper'

describe 'UserSignout' do 
  let(:user) {FactoryGirl.create(:user)}

  it "shold disconnect user" do
    visit new_user_session_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Log in'
    visit root_path
    click_link 'Logout'

    page.should have_content 'Signed out successfully'
  end
end
