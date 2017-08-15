require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:admin) { build(:user, admin: true) }
  let(:headers) { valid_headers.except('Authentication') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: admin.password)
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message']).to match(/Validation failed:/)
      end
    end
  end

  describe 'DELETE /user/:id' do
    # Create the user authorized to delete a user
    let(:admin) { create(:user) }
    # Create valid header with authorized user
    let(:headers) { valid_headers }
    # Create a random user to delete
    let(:user) { create(:user) }

    before { delete "/user/#{user.id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
