FactoryGirl.define do
  factory :boost do
    content nil
    task nil
  end

  factory :boost_text, parent: :boost do |f|
    f.text {Faker::Hacker.say_something_smart}
    f.type "TextBoost"
  end

  factory :boost_text_invalid, parent: :boost do |f|
    f.text nil
    f.type "TextBoost"
  end

  factory :boost_picture_invalid, parent: :boost do |f|
    f.image nil
    f.type "PictureBoost"
  end

end
