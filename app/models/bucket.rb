class Bucket < ApplicationRecord
  belongs_to :aws_profile
  belongs_to :user

  validates :aws_profile,
  presence: true

  validates :user,
  presence: true

  validates :bucket_name,
  presence: true
end
