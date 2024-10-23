class DashboardController < ApplicationController
  before_action :authenticate_user

  def index
    render json: { message: "Welcome to your dashboard!" }, status: :ok
  end
end
