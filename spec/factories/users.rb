include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    login { Faker::Name.first_name }
    password  { Faker::Internet.password }
    email { Faker::Internet.email}
    description {Faker::Hacker.say_something_smart}
    avatar { fixture_file_upload(Rails.root.join('spec', 'files', 'booostme_400vert.png'), 'image/png') }
  end

end
