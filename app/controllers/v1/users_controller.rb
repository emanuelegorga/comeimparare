# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:update, :show, :destroy]
    skip_before_action :authorize_request, only: :create

    def index
      authorize @current_user
      users = User.all.paginate(page: params[:page], per_page: 20)
      json_response(users)
    end

    def show
      authorize @current_user
      json_response(@user)
    end

    def create
      user = User.create!(user_params)
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      json_response(response, :created)
    end

    def update
      authorize @current_user
      @user.add_role(:admin) if params[:isAdmin]
      @user.update(user_params)
      head :no_content
    end

    def destroy
      authorize @current_user
      @user.destroy
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
        :avatar_url,
        :isAdmin
      )
    end
  end
end
