FactoryGirl.define do
  factory :bucket do
    bucket_name { Faker::App.name }
    prefix nil
    bkt_upload   false
    bkt_download false
    bkt_copy     false
    bkt_delete   false
  end
end
