class RenameVinyls < ActiveRecord::Migration
  def change
    rename_table :vinyls, :albums
  end
end
