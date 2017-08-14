class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  # returns auth token once user is authenticated
  def authenticate
    json_response(
      auth_token: AuthenticateUser.new(
        auth_params[:username],
        auth_params[:password]
      ).call
    )
  end

  private

  def auth_params
    params.permit(:username, :password)
  end
end
