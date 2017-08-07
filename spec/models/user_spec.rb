require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:buckets).dependent(:destroy) }
  it { should have_many(:aws_profiles) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
end
