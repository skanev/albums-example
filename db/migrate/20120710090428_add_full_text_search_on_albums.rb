class AddFullTextSearchOnAlbums < ActiveRecord::Migration
  def up
    execute "CREATE INDEX albums_name ON albums USING gin(to_tsvector('english', name))"
    execute "CREATE INDEX albums_artist ON albums USING gin(to_tsvector('english', artist))"
  end

  def down
    execute 'DROP INDEX albums_artist'
    execute 'DROP INDEX albums_name'
  end
end
