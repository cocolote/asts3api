require 'rails_helper'

RSpec.describe AwsProfile, type: :model do
  it { should have_many(:buckets).dependent(:destroy) }
  it { should have_many(:users) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:access_key) }
  it { should validate_presence_of(:secret_access_key) }
end
