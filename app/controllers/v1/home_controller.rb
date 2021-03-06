# frozen_string_literal: true

module V1
  class HomeController < ApplicationController
    skip_before_action :authorize_request, only: :privacy_policy

    def privacy_policy
      json_response({})
    end
  end
end