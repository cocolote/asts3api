class UserBucketsController < ApplicationController
  before_action :set_bucket, only: [:show, :update, :destroy]

  def index
    json_response(@current_user.buckets)
  end

  def create
    @bucket = @current_user.buckets.create!(bucket_params)
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

  def set_bucket
    @bucket = @current_user.buckets.find_by!(id: params[:id]) if @current_user
  end

  def bucket_params
    params.permit(
      :aws_profile_id,
      :bucket_name,
      :prefix,
      :bkt_upload,
      :bkt_download,
      :bkt_copy,
      :bkt_delete
    )
  end
end
