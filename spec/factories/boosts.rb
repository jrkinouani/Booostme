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

  factory :boost_money, parent: :boost do |f|
    f.money {[100, 500, 1000].sample}
    f.type "MoneyBoost"
  end

  factory :boost_money_invalid, parent: :boost do |f|
    f.money nil
    f.type "MoneyBoost"
  end

end
