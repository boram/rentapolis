class SessionsController < ApplicationController
  def new
  end

  def create
    user = if auth_hash = env["omniauth.auth"]
      User.from_omniauth(auth_hash)
    else
      User.authenticate(params[:email], params[:password])
    end

    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Successfully signed in'
    else
      flash.now.alert = 'We do not recognize that email or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
