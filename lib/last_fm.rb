require 'open-uri'
require 'rest_client'
require 'json'
require 'custom_exceptions'

class LastFm

  def self.get_user_selections(username, lastfm_username) 
    escaped_username = URI.escape(lastfm_username)
    lastfm_key = ENV["LASTFM_KEY"]
    query = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=user.gettopalbums&user=#{escaped_username}&api_key=#{lastfm_key}&format=json")
    parsed_query = JSON.parse(query)

    for i in 1..8 do
      artist = parsed_query["topalbums"]["album"][i]["artist"]["name"]
      title = parsed_query["topalbums"]["album"][i]["name"]
      AlbumSelectionServices.select_album(lastfm_username, artist, title)
    end
  end
  
 
  def self.fetch(artist, title)
    escaped_artist = URI.escape(artist)    
    escaped_title = URI.escape(title)
    lastfm_key = ENV["LASTFM_KEY"]
    query = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=#{lastfm_key}&artist=#{escaped_artist}&album=#{escaped_title}&autocorrect=1&format=json")
    album_info = JSON.parse(query)
    if album_info.key?('error')

    else
      artist = album_info['album']['artist']
      title = album_info['album']['name']
      
      album_art = album_info['album']['image'][-1]['#text']

      if album_art.nil?
        album_art_open = open(album_art)
      else

      end

      return { 'artist' =>  artist, 'title' => title, 'album_art_open' => album_art }
    end
  end
end

