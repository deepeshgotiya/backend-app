class ApplicationController < ActionController::API
  before_action :authenticate_user_with_jwt

  def authenticate_user_with_jwt
    binding.pry
    token = request.headers['Authorization']&.split(' ')&.last
    if token.present?
      begin
        decoded_token = JWT.decode(token, Rails.application.secret_key_base)
        user_id = decoded_token[0]['user_id']
        @current_user = User.find_by(id: user_id)
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Token missing' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def logged_in?
    !!current_user
  end
end
