class CreatePolygons < ActiveRecord::Migration
  def up
    create_table :polygons do |t|
      t.integer :neighborhood_id
      t.polygon :region, srid: 3785
    end

    add_index :polygons, :region, spatial: true
  end

  def down
    remove_index :polygons, :region
    drop_table :polygons
  end
end
