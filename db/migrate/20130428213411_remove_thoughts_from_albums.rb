class RemoveThoughtsFromAlbums < ActiveRecord::Migration
  def change
    remove_column :albums, :thoughts
  end
end
