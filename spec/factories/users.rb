FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password_digest { Faker::Internet.password }
    email { Faker::Internet.free_email }
    first_name { Faker::StarTrek.character }
    last_name { Faker::StarWars.character }
    admin nil
  end
end
