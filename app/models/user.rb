class User < ApplicationRecord
  has_secure_password

  has_many :buckets, dependent: :destroy
  has_many :aws_profiles, through: :buckets

  validates :username,
  presence: true

  validates :password_digest,
  presence: true
end
