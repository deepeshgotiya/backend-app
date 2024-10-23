class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def after_sign_in_path_for(resource)
    super(resource)
  end

  private

  def respond_with(resource, _opts = {})
    render json: { message: 'Logged in successfully', token: jwt_token(resource) }, status: :ok
  end

  def respond_to_on_destroy
    head :no_content
  end

  def jwt_token(user)
    JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secret_key_base)
  end
end
