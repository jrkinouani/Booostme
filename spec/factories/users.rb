FactoryGirl.define do
  factory :user do
    login { Faker::Name.first_name }
    password  { Faker::Internet.password }
    email { Faker::Internet.email}
    description {Faker::Hacker.say_something_smart}
    avatar ""
  end

end
