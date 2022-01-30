# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:update, :index]
    skip_before_action :authorize_request, only: :create

    def index
      authorize @user
      users = User.all.paginate(page: params[:page], per_page: 20)
      json_response(users)
    end

    def create
      user = User.create!(user_params)
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      json_response(response, :created)
    end

    def update
      authorize @user
      @user.update
      head :no_content
    end

    private

    def set_user
      @user = User.find(params[:id])
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
