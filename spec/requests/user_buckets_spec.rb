require 'rails_helper'

RSpec.describe 'User Buckets API', type: :request do
  # Initialize test data
  let(:admin) { create(:user, admin: true) }
  let(:aws_profile) { create(:aws_profile) }

  let!(:buckets) {
    create_list(
      :bucket,
      10,
      aws_profile_id: aws_profile.id,
      user_id: admin.id
    )
  }

  let(:user_id) { admin.id }
  let(:aws_profile_id) { aws_profile.id }
  let(:id) { buckets.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET user/:user_id/buckets
  describe 'GET user/:user_id/buckets' do
    before { get "/user/#{user_id}/buckets", headers: headers }

    context 'When user exists' do
      it 'returns all buckets' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for POST user/:user_id/buckets
  describe 'POST user/:user_id/buckets' do
    let(:valid_attributes) {
      {
        aws_profile_id: aws_profile_id,
        bucket_name: 'myBucket',
        prefix: 'tmp/',
        bkt_upload: true,
        bkt_download: true,
        bkt_copy: true,
        bkt_delete: true,
      }.to_json
    }

    context 'When request is valid' do
      before {
        post "/user/#{user_id}/buckets",
        params: valid_attributes,
        headers: headers
      }

      it 'creates a bucket' do
        expect(json['bucket_name']).to eq('myBucket')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'When request is invalid' do
      before {
        post "/user/#{user_id}/buckets",
        params: {}.to_json,
        headers: headers
      }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed:/)
      end
    end
  end

  # Test suite for GET user/:user_id/buckets/:id
  describe 'GET user/:user_id/buckets/:id' do
    before { get "/user/#{user_id}/buckets/#{id}", headers: headers }

    context 'When user bucket exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the bucket' do
        expect(json['id']).to eq(id)
      end
    end

    context 'When user bucket does not exists' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bucket/)
      end
    end
  end

  # Test suite for PUT user/:user_id/buckets/:id
  describe 'PUT user/:user_id/buckets/:id' do
    let(:valid_attributes) { { bucket_name: 'ast_bucket' }.to_json }
    before {
      put "/user/#{user_id}/buckets/#{id}",
      params: valid_attributes,
      headers: headers
    }

    context 'When the bucket exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the bucket' do
        updated_bucket = Bucket.find(id)
        expect(updated_bucket.bucket_name).to match(/ast_bucket/)
      end
    end

    context 'When the bucket does not exists' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Bucket/)
      end
    end
  end

  # Test suite for DELETE user/:user_id/buckets/:id
  describe 'DELETE user/:user_id/buckets/:id' do
    before { delete "/user/#{user_id}/buckets/#{id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
