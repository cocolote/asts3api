class UserController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  skip_before_action :authorize_request, only: :create
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.username, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def update
    @user.update(user_params)
    head :no_content
  end

  def destroy
    @user.destroy
    head :no_content
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

  def set_user
    @user = User.find(params[:id])
  end
end
