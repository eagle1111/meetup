class Api::V1::BaseController < ApplicationController
  attr_accessor :current_user
  protect_from_forgery with: :null_session

  before_action :destroy_session

  skip_before_action :verify_authenticity_token

  def destroy_session
    request.session_options[:skip] = true
  end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

     user_email = options.blank?? nil : options[:email]
     user = user_email && User.find_by(email: user_email)

     if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
       self.current_user = user
     else
       return unauthenticated!
     end
  end

  def unauthenticated!
    api_error(status: 401)
  end

  def api_error(opts = {})
    render nothing: true, status: opts[:status]
  end
end
