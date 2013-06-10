class Api::SessionsController < ApplicationController
  def create
    auth = Authentication.new(params, env["omniauth.auth"])
    if auth.authenticated?
      session[:user_id] = auth.user.id

      render json: {
        user: {
          id: auth.user.id,
          email: auth.user.email
        }
      }, status: :created
    else
      render json: {
        message: 'Invalid email or password'
      }, status: 401
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {}, status: :accepted
  end
end
