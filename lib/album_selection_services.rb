class AlbumSelectionServices


  def self.select_album(user, artist, title)
    album = find_or_create_album(artist, title)
    return user.selections.create(album: album)
  end

  def self.find_or_create_album(artist, title)
    # returns either an album or an error
    album = Album.where(artist: artist, title: title).first

    return album if album
    
    album_info = LastFm.fetch(artist, title)
    if album_info
      Album.create(artist: album_info['artist'], title: album_info['title'], album_art: album_info['album_art'])
    else
      redirect_to album_art_path
    end
  end


end
