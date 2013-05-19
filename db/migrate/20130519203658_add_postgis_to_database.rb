class AddPostgisToDatabase < ActiveRecord::Migration
  def up
    execute("CREATE EXTENSION postgis;")
  end

  def down
    execute("DROP EXTENSION postgis;")
  end
end
