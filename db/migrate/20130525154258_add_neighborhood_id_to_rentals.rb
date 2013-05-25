class AddNeighborhoodIdToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :neighborhood_id, :integer
  end
end
