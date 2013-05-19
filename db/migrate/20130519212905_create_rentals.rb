class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.integer :beds
      t.decimal :baths, precision: 2, scale: 1
      t.string  :unit_type
      t.integer :sqft
      t.text    :description
      t.decimal :rent, precision: 6, scale: 2
      t.string  :rent_per
      t.decimal :deposit, precision: 6, scale: 2
      t.string  :street
      t.string  :city
      t.string  :state
      t.string  :zip
      t.point   :projected_coordinates, srid: 3785

      t.timestamps
    end

    add_index :rentals, :projected_coordinates, spatial: true
  end
end
