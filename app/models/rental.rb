class Rental < ActiveRecord::Base

  belongs_to :neighborhood

  validates :beds, presence: true, if: :require_beds?
  validates :baths, presence: true, if: :require_baths?
  validates :unit_type, presence: true
  validates :description, presence: true
  validates :rent, presence: true
  validates :rent_per, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  GEOFACTORY = RGeo::Geographic.simple_mercator_factory
  set_rgeo_factory_for_column :projected_coordinates, GEOFACTORY.projection_factory

  geocoded_by :address do |rental, results|
    if geo = results.first
      rental.projected_coordinates = GEOFACTORY.point(geo.longitude, geo.latitude).projection
    end

    rental.associate_neighborhood
  end

  after_validation :geocode, if: :geocode_address?

  def short_description
    if single_room?
      unit_type
    else
      "#{beds} bed #{baths} bath #{unit_type}"
    end
  end

  def baths
    return unless baths_attr = read_attribute(:baths)

    if baths_attr % 1 == 0
      baths_attr.to_i
    else
      baths_attr
    end
  end

  def address
    area = [city, state, zip].join ' '
    "#{street}, #{area}"
  end

  def coordinates
    [geographic_point.latitude, geographic_point.longitude]
  end

  def latitude
    geographic_point.latitude
  end

  def longitude
    geographic_point.longitude
  end

  def associate_neighborhood
    self.neighborhood = begin
      if polygon = Polygon.find_by_coordinates(latitude, longitude)
        polygon.neighborhood
      end
    end
  end

  protected

  def single_room?
    unit_type.in? %w(single bachelor)
  end

  def require_beds?
    !single_room?
  end
  alias_method :require_baths?, :require_beds?

  def geocode_address?
    errors.empty? && (new_record? || street_changed? || city_changed? || state_changed? || zip_changed?)
  end

  def geographic_point
    geographic_point = GEOFACTORY.unproject(projected_coordinates)
  end
end
