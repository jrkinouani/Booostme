FactoryGirl.define do
  sequence :composite_id do |n| 
    n
  end

  factory :task do
    id {FactoryGirl.generate( :composite_id )}
    title {Faker::Name.title}
    start_date {Date.today}
    end_date {Faker::Time.between((Date.today + 3), (Date.today + 5))}
    hour {Faker::Number.digit}
    state "ongoing"
    user nil
  end

  factory :invalid_task, parent: :task do |f|
    f.title nil
  end

end
