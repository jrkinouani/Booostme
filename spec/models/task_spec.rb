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
  it {should validate_presence_of(:title)}

  it {should respond_to(:hour)}
  it {should allow_value(0).for(:hour)}
  it {should allow_value(12).for(:hour)}
  it {should allow_value(23).for(:hour)}
  it {should_not allow_value(-1).for(:hour)}
  it {should_not allow_value(24).for(:hour)}
  it {should_not allow_value(26).for(:hour)}

  it {should respond_to(:state)}

  it {should respond_to(:validation_image)}

  it {should respond_to(:cover_image)}

  it {should respond_to(:end_date)}
  it {should validate_presence_of(:end_date)}

  it "should allow value date today +1 for end_date" do
    task = FactoryGirl.build(:task, end_date: (Date.today +1))
    task.should_not be_valid
  end


  it "should not allow value date today for end_date" do
    task = FactoryGirl.build(:task, end_date: Date.today)
    task.should_not be_valid
  end

  it "should not allow 2 date ago end_date" do
    task = FactoryGirl.build(:task, end_date: 2.days.ago)
    task.should_not be_valid
  end


  it {should respond_to(:start_date)}
  it {should validate_presence_of(:start_date)}  
  # it {should allow_value(Date.today).for(:start_date)}

  it "should allow value date today for start_date" do
    task = FactoryGirl.build(:task, start_date: Date.today)
    task.should be_valid
  end


  it "should not allow 1 date ago start_date" do
    task = FactoryGirl.build(:task, start_date: 1.days.ago)
    task.should_not be_valid
  end

  it "should not allow date  +1  for start_date" do
    task = FactoryGirl.build(:task, start_date: Date.today + 1)
    task.should_not be_valid
  end

  it {should belong_to(:user)}

  it {should have_many(:boosts)}

end
