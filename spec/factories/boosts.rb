FactoryGirl.define do
  factory :boost do
    content {Faker::Hacker.say_something_smart}
    task nil
  end

end
