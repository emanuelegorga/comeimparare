# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include Response
  include ExceptionHandler
  include Pundit

  protect_from_forgery

  before_action :authorize_request

  attr_reader :current_user

  def default_url_options
    { host: Rails.env.production? ? 'comeimparare.herokuapp.com' : 'localhost:3000' }
  end

  private

  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
