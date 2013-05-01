class AlbumSelectionServices
  def self.select_album(user, artist, title)
    album = Album.where(artist: artist, title: title).first
    unless album
      album_art = open(LastFm.fetch_album_art(artist, title))
      album = Album.create(artist: artist, title: title, album_art: album_art)
    end
    user.selections.create(album: album)
  end
end
