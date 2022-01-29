# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    skip_before_action :authorize_request, only: :create

    def index
      users = User.all
      json_response(users)
    end

    def create
      user = User.create!(user_params)
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      json_response(response, :created)
    end

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :platform,
        :avatar_url
      )
    end
  end
end
