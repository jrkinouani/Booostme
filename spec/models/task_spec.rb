require 'rails_helper'

# RSpec.describe Task, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

describe Task do 
  before(:each) do 
    @task = FactoryGirl.create(:task)
  end

  subject {@task}

  it {should respond_to(:title)}

  it {should respond_to(:end_date)}
  it {should allow_value(Date.today + 3).for(:end_date)}
  it {should_not allow_value(Date.today + 1).for(:end_date)}
  it {should_not allow_value(Date.today + 2).for(:end_date)}
  it {should_not allow_value(2.days.ago).for(:end_date)}

  it {should respond_to(:start_date)}
  it {should allow_value(Date.today).for(:start_date)}
  it {should_not allow_value(1.days.ago).for(:start_date)}
  it {should_not allow_value(Date.today + 1).for(:start_date)}

  it {should belong_to(:user)}

end
