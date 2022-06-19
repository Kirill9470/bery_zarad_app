class Api::V1::ApplicationController < ApplicationController
  before_action :auth

  protected

  attr_reader :current_user

  def auth
    result = AuthUser.call(token: request.headers['Authorization'])
    render json: { error: result.error }, status: :unauthorized if result.failure?

    @current_user = result.user
  end

end
