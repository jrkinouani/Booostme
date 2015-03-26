require 'rails_helper'

RSpec.describe "devise/sessions/new.html.erb", type: :view do
  before(:each) do 
    @user = FactoryGirl.build(:user)
    assign :resource, @user

    render
  end

  it "display a form to sign in" do 
    rendered.should have_selector("form[action='/users/sign_in']")
  end

  it "display a field to enter a Email" do 
    rendered.should have_selector("form[action='/users/sign_in'] label", :text => "Email")
    rendered.should have_selector("form[action='/users/sign_in'] input#user_email")
  end

  it "display a field to enter a Password" do 
    rendered.should have_selector("form[action='/users/sign_in'] label", :text => "Password")
    rendered.should have_selector("form[action='/users/sign_in'] input#user_password")
  end


end
