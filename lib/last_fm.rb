require 'open-uri'
require 'rest_client'
require 'json'

class LastFm
 
  def self.fetch_album_art(artist, title)
    escaped_artist = URI.escape(artist)    
    escaped_title = URI.escape(title)
    lastfm_key = ENV["LASTFM_KEY"]
    query = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=#{lastfm_key}&artist=#{escaped_artist}&album=#{escaped_title}&autocorrect=1&format=json")
    value = JSON.parse(query)
    unless value.key?('errors')
      result = value.fetch('album').fetch('image')[3].fetch('#text')
    end
  end
end

