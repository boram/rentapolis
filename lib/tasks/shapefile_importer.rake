namespace :shp do
  task import: :environment do
    Rake::Task['shp:import:latimes'].invoke
    Rake::Task['shp:import:smcity'].invoke
    Rake::Task['shp:import:zillow'].invoke
  end

  namespace :import do
    task latimes: :environment do
      ShapefileImporter.new('latimes-lacounty/la_county.shp', 'latimes').fetch
    end

    task smcity: :environment do
      ShapefileImporter.new('smcity-santamonica/nbrhd_bdry.shp', 'smcity').fetch
    end

    task zillow: :environment do
      ShapefileImporter.new('zillow-ca/ZillowNeighborhoods-CA.shp', 'zillow').fetch
    end
  end
end
