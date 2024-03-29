Rake::Task['shp:import'].invoke

description = <<-DESC.strip_heredoc
  You probably haven't heard of them odio swag, lomo 8-bit irure occaecat voluptate pop-up dreamcatcher
  butcher tofu accusamus narwhal. Id scenester organic keffiyeh. Photo booth lo-fi tempor master
  cleanse. Cosby sweater lo-fi DIY semiotics leggings banh mi. Dolor labore laboris gentrify.
  Farm-to-table biodiesel sunt beard, helvetica voluptate sriracha pickled. Exercitation tumblr mlkshk,
  photo booth food truck do nulla dolore id lomo blog ut.
DESC

Rental.create beds: 1, baths: 1, unit_type: 'apartment', sqft: 600, rent: 1000.00, rent_per: 'month', deposit: 1000.00,
  description: description, street: '12565 Washington Blvd', city: 'Los Angeles', state: 'CA', zip: '90066'

Rental.create beds: 2, baths: 2, unit_type: 'apartment', sqft: 960, rent: 1200.00, rent_per: 'month',
  description: description, street: '727 North Broadway', city: 'Los Angeles', state: 'CA', zip: '90012'

Rental.create beds: 2, baths: 1.5, unit_type: 'townhouse', sqft: 850, rent: 2000.00, rent_per: 'month', deposit: 2000.00,
  description: description, street: '1600 Main Street', city: 'Venice', state: 'CA', zip: '90291'
