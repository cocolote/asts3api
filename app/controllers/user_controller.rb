class UserController < ApplicationController
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.username, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :username,
      :password,
      :email,
      :first_name,
      :last_name,
      :admin
    )
  end
end
