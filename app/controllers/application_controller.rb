# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include Response
  include ExceptionHandler
  include Pundit

  protect_from_forgery

  before_action :authorize_request, except: :home

  attr_reader :current_user

  def default_url_options
    { host: Rails.env.production? ? 'comeimparare.onrender.com' : 'localhost:3000' }
  end

  def home
    render json: { 
      message: 'Welcome to ComeImparare API. This API serves the UI of ComeImparare, a platform for online courses. You can find the live website at https://comeimparare.netlify.app/'
    }
  end

  private

  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
