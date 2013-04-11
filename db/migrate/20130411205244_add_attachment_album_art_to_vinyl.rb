class AddAttachmentAlbumArtToVinyl < ActiveRecord::Migration
  def self.up
    add_column :vinyls, :album_art_file_name, :string
    add_column :vinyls, :album_art_content_type, :string
    add_column :vinyls, :album_art_file_size, :integer
    add_column :vinyls, :album_art_updated_at, :datetime
  end

  def self.down
    remove_column :vinyls, :album_art_file_name
    remove_column :vinyls, :album_art_content_type
    remove_column :vinyls, :album_art_file_size
    remove_column :vinyls, :album_art_updated_at
  end
end
