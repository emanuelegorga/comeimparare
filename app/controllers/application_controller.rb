# frozen_string_literal: true

class ApplicationController < ActionController::API
  def default_url_options
    { host: ENV['DOMAIN'] || 'localhost:3000' }
  end

  def current_page
    return 1 unless params[:page]
    return params[:page] if params[:page].is_a?(String)
    return params.dig(:page, :number) if params[:page].is_a?(Hash)
    1
  end

  def per_page
    return unless params[:page]
    return params[:per_page] if params[:per_page].is_a?(String)
    return params.dig(:page, :size) if params[:page].is_a?(Hash)
    1
  end

  def current_user
    User.first_or_create(
      login: 'admin@comeimparare.it',
      name: 'emanuele',
      is_admin: true
    )
  end
end
