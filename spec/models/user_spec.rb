require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe User do 
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  subject {@user}

  it { should  respond_to(:first_name)}
  it { should validate_presence_of(:first_name)}

  it { should  respond_to(:last_name)}
  it { should  validate_presence_of(:last_name)}

  it { should  respond_to(:email)}
  it { should  validate_presence_of(:email)}
  it { should allow_value("test@example.com").for(:email)}
  it { should_not allow_value("test").for(:email)}

  it { should  respond_to(:password)}
  it { should  validate_presence_of(:password)}
  it { should  validate_length_of(:password).is_at_least(8)}

  it { should  respond_to(:avatar)}
  it { should_not validate_presence_of(:avatar)}

  it { should  respond_to(:description)}
  it { should_not validate_presence_of(:description)}

  it { should have_many(:tasks)}


end
