require 'rails_helper'

RSpec.describe "devise/registrations/new.html.erb", type: :view do
  before(:each) do 
    @user = FactoryGirl.build(:user)
    assign :resource, @user

    render
  end

  it "display a form to sign up" do 
    rendered.should have_selector("form[action='/users']")
  end

  it "display a field to enter a Email" do 
    rendered.should have_selector("form[action='/users'] label", :text => "Email")
    rendered.should have_selector("form[action='/users'] input#user_email")
  end

  it "display a field to enter a Password" do 
    rendered.should have_selector("form[action='/users'] label", :text => "Password")
    rendered.should have_selector("form[action='/users'] input#user_password")
  end

  it "display a field to enter a First name" do 
    rendered.should have_selector("form[action='/users'] label", :text => "Login")
    rendered.should have_selector("form[action='/users'] input#user_login")
  end

  it "display a field to enter Password confirmation" do 
    rendered.should have_selector("form[action='/users'] label", :text => "Password confirmation")
    rendered.should have_selector("form[action='/users'] input#user_password_confirmation")
  end

end
