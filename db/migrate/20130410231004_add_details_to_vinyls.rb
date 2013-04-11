class AddDetailsToVinyls < ActiveRecord::Migration
  def change
    create_table :vinyls do |t|
      t.string :title, :artist, :format, :genre, :rating
      t.timestamps
    end
  end
end
