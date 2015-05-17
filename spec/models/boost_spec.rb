require 'rails_helper'

RSpec.describe Boost, type: :model do
  before(:each) do 
    @boost = FactoryGirl.create(:boost)
  end

  subject {@boost}

  it {should respond_to(:content)}
  it {should  validate_length_of(:text).is_at_most(140)}

  it {should respond_to(:image)}

  it {should respond_to(:money)}

  it {should belong_to(:task)}
  it {should belong_to(:user)}
end
