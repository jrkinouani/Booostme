require 'rails_helper'

# RSpec.describe UserController, type: :controller do

# end

describe UserController, type: :controller do 

  before(:each) do 
    login_user
  end

  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  it "should have a current_user eql nil" do
    sign_out subject.current_user
    subject.current_user.should be_nil
  end
end
