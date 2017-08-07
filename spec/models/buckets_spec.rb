require 'rails_helper'

RSpec.describe Bucket, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:aws_profile) }

  it { should validate_presence_of(:aws_profile) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:bucket_name) }
end
