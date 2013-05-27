class Api::RentalsController < ApplicationController
  respond_to :json

  def index
    respond_with Rental.all
  end
end