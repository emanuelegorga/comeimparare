# frozen_string_literal: true

module V1
  class AuthenticationController < ApplicationController
    skip_before_action :authorize_request, only: :authenticate

    def authenticate
      auth_token =
        AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
      user = User.find_by(email: auth_params[:email])
      json_response({auth_token: auth_token, id: user.id, name: user.name})
    end

    private

    def auth_params
      params.require(:user).permit(:email, :password)
    end
  end
end
