FactoryGirl.define do
  factory :aws_profile do
    name { Faker::Internet.user_name }
    access_key { Faker::Internet.password(20) }
    secret_access_key { Faker::Internet.password(40) }
  end
end
