class Api::UsersController < ApplicationController
  respond_to :json

  def index
    respond_with User.all
  end

  def show
    if params[:id] == 'current'
      respond_with current_user
    else
      respond_with User.find(params[:id])
    end
  end
end