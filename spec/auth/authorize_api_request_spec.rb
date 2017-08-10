require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  # Create a test admin user
  let(:admin) { create(:user, admin: true) }
  # Mock `Authorization` header
  let(:header) { { 'Authorization' => token_generator(admin.id) } }
  # Invalid request subject
  subject(:invalid_request_obj) { described_class.new({}) }
  # Valid request subject
  subject(:valid_request_obj) { described_class.new(header) }

  # Test suite for AuthorizedApiRequest#call
  # This is the entry point into the service calls
  describe '#call' do
    # returns user object when request is valid
    context 'When valid request' do
      it 'returns user object' do
        result = valid_request_obj.call
        expect(result[:user]).to eq(admin)
      end
    end

    # returns error message when invalid request
    context 'When invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_obj) do
          # custom helper method `token_generator`
          described_class.new('Authorization' => token_generator(0))
        end

        it 'raises a InvalidToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'when token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(admin.id) } }
        subject(:request_obj) { described_class.new(header) }

        it 'raises ExceptionHandler::ExpiredSignature error' do
          expect { request_obj.call }
            .to raise_error(ExceptionHandler::ExpiredSignature, /Signature has expired/)
        end
      end
    end
  end
end
