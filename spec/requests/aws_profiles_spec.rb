require 'rails_helper'

RSpec.describe 'AwsProfiles API', type: :request do
  # Initialize test data
  let!(:aws_profiles) { create_list(:aws_profile, 3) }
  let(:aws_profile_id) { aws_profiles.first.id }

  # Test suit for GET /profiles
  describe 'GET /aws_profiles' do
    before { get '/aws_profiles' }

    it 'returns aws_profiles' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suit for POST /profiles
  describe 'POST /aws_profiles' do
    let(:valid_attributes) {
      {
        name: 'ezelop',
        access_key: 'asdfqwerasdfqwerasdf',
        secret_access_key: 'asdfqwerasdfqwerasdfasdfqwerasdfqwerasdf'
      }
    }

    context 'When the request is valid' do
      before { post '/aws_profiles', params: valid_attributes }

      it 'creates an aws_profile' do
        expect(json['name']).to eq('ezelop')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'When the request is invalid' do
      before { post '/aws_profiles', params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed:/)
      end
    end
  end

  # Test suit for GET/profiles/:id
  describe 'GET /aws_profiles/:id' do
    before { get "/aws_profiles/#{aws_profile_id}" }

    context 'When the profile exists' do
      it 'returns the profile' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(aws_profile_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'When the profile does not exists' do
      let(:aws_profile_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find AwsProfile/)
      end
    end
  end

  # Test suit for PUT /profiles/:id
  describe 'PUT /aws_profiles/:id' do
    let(:valid_attributes) { { name: 'lopeze' } }

    context 'When the profile exists' do
      before { put "/aws_profiles/#{aws_profile_id}", params: valid_attributes }

      it 'updates the profile' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suit for DELETE /profiles/:id
  describe 'DELETE /aws_profiles/:id' do
    before { delete "/aws_profiles/#{aws_profile_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
