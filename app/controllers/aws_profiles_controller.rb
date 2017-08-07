class AwsProfilesController < ApplicationController
  before_action :set_aws_profile, only: [:show, :update, :destroy]

  def index
    @aws_profiles = AwsProfile.all
    json_response(@aws_profiles)
  end

  def create
    @aws_profile = AwsProfile.create!(aws_profile_params)
    json_response(@aws_profile, :created)
  end

  def show
    json_response(@aws_profile)
  end

  private

  def aws_profile_params
    params.permit(:name, :access_key, :secret_access_key)
  end

  def set_aws_profile
    @aws_profile = AwsProfile.find(params[:id])
  end
end
