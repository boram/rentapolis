class RentalSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper

  attributes :id, :posted_at, :short_description, :sqft,
    :description, :rent, :rent_per, :deposit, :street_address, :region,
    :latitude, :longitude, :neighborhood_id, :neighborhood

  def posted_at
    I18n.l object.updated_at, format: :datetime
  end

  def short_description
    if object.single_room?
      object.unit_type
    else
      "#{object.beds} bed #{object.baths} bath #{object.unit_type}"
    end
  end

  def rent
    number_to_currency object.rent
  end

  def deposit
    number_to_currency object.deposit
  end

  def street_address
    object.street
  end

  def neighborhood
    object.try(:neighborhood).try :name
  end
end
