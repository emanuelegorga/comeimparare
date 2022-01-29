# frozen_string_literal: true

class ApplicationController < ActionController::API
  def default_url_options
    { host: ENV['DOMAIN'] || 'localhost:3000' }
  end
end
