class Neighborhood < ActiveRecord::Base
  has_many :polygons
  has_many :rentals
end
