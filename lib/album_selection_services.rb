class AlbumSelectionServices
  def self.select_album(user, artist, title)
    album = find_or_create_album(artist, title)
    return user.selections.create(album: album)
  end

  def self.find_or_create_album(artist, title)
    # returns either an album or an error
    album = Album.where(artist: artist, title: title).first
    return album if album
    
    album_art = LastFm.fetch_album_art(artist, title)
    Album.create(artist: artist, title: title, album_art: album_art)
  end
end
