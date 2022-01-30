# frozen_string_literal: true

module V1
  class HomeController < ApplicationController
    def privacy_policy
      json_response({})
    end
  end
end