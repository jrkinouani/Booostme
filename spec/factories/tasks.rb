FactoryGirl.define do
  factory :task do
    title {Faker::Name.title}
    start_date {Date.today}
    end_date {Faker::Time.between((Date.today + 3), (Date.today + 5))}
    user nil
  end

  factory :invalid_task, parent: :task do |f|
    f.title nil
  end

end
