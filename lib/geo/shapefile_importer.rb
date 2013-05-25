class ShapefileImporter

  DATAFILE_ROOT = 'lib/geo/data'

  attr_accessor :filename, :source

  def initialize(filename, source)
    self.filename = filename
    self.source = source
  end

  def fetch
    RGeo::Shapefile::Reader.open(
      File.join(Rails.root, DATAFILE_ROOT, filename),
      factory: Polygon::GEOFACTORY
    ) do |file|

      file.each do |record|
        record_attributes = record.attributes

        name = record_attributes['Name'] || record_attributes['NAME'] || record_attributes['NEIGHBOR']
        incorporated = record_attributes['INCORP'] == 'False' ? false : true

        neighborhood = Neighborhood.where(name: name, source: source).first || begin
          Neighborhood.create!({
            name: name,
            city: record_attributes['CITY'],
            county: record_attributes['COUNTY'],
            incorporated: incorporated,
            source: source
          })
        end

        if record.geometry
          record.geometry.projection.each do |polygon|
            neighborhood.polygons.create! region: polygon
          end
        end
      end

      file.rewind
      record = file.next
    end
  end
end
