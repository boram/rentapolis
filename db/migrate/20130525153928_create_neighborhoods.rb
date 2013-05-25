class CreateNeighborhoods < ActiveRecord::Migration
  def up
    create_table :neighborhoods do |t|
      t.string :name
      t.string :city
      t.string :county
      t.boolean :incorporated
      t.string :source
    end

    add_index :neighborhoods, :name
  end

  def down
    remove_index :neighborhoods, :name
    drop_table :neighborhoods
  end
end
