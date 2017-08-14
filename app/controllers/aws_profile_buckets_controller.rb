class AwsProfileBucketsController < ApplicationController
  before_action :set_aws_profile
  before_action :set_bucket, only: [:show, :update, :destroy]

  def index
    json_response(@aws_profile.buckets)
  end

  def create
    @bucket = @aws_profile.buckets.create!(bucket_params)
    json_response(@bucket, :created)
  end

  def show
    json_response(@bucket)
  end

  def update
    @bucket.update(bucket_params)
    head :no_content
  end

  def destroy
    @bucket.destroy
    head :no_content
  end

  private

  def set_aws_profile
    @aws_profile = AwsProfile.find(params[:aws_profile_id])
  end

  def set_bucket
    @bucket = @aws_profile.buckets.find_by!(id: params[:id]) if @aws_profile
  end

  def bucket_params
    params.permit(
      :user_id,
      :bucket_name,
      :prefix,
      :bkt_upload,
      :bkt_download,
      :bkt_copy,
      :bkt_delete
    )
  end
end
