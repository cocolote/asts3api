class AwsProfile < ApplicationRecord
  has_many :buckets, dependent: :destroy
  has_many :users, through: :buckets

  validates :name,
  presence: true

  validates :access_key,
  presence: true

  validates :secret_access_key,
  presence: true
end
