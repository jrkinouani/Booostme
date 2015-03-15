FactoryGirl.define do
  factory :task do
    title {Faker::Name.title}
    start_date {Date.today}
    end_date {Faker::Time.between((Date.today + 3), (Date.today + 5))}
    user nil
  end

end
