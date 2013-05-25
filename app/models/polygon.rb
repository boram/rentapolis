class Polygon < ActiveRecord::Base
  belongs_to :neighborhood

  GEOFACTORY = RGeo::Geographic.simple_mercator_factory
  set_rgeo_factory_for_column(:region, GEOFACTORY.projection_factory)

  EWKB = RGeo::WKRep::WKBGenerator.new(
    type_format: :ewkb,
    emit_ewkb_srid: true,
    hex_format: true
  )

  def self.find_by_coordinates(lat, lon)
    where("ST_Intersects(region, ST_GeomFromEWKB(E'\\\\x#{ewkb_coordinates(lat, lon)}'))").first
  end

  protected

    def self.ewkb_coordinates(lat, lon)
      EWKB.generate projected_coordinates(lat, lon)
    end

    def self.projected_coordinates(lat, lon)
      GEOFACTORY.point(lon, lat).projection
    end
end
