require 'rest_client'
require 'json'

class Lastfm
 
  def fetch_album_art(title)
    escaped_title = URI::escape(title)
    lastfm_key = ENV["LASTFM_KEY"]
    query = JSON.parse(RestClient.get("http://ws.audioscrobbler.com/2.0/?method=album.search&album=#{escaped_title}&api_key=#{lastfm_key}&format=json"))
    unless query.key?('errors')
      results = query.fetch('results').fetch('albummatches').fetch('album')[0].fetch('image').last.fetch('#text')
    end
  end

  def fetch_album_genre(artist, title)
    escaped_artist = URI::escape(artist)
    escaped_title = URI::escape(title)
    lastfm_key = ENV["LASTFM_KEY"]
    query = JSON.parse(RestClient.get("http://ws.audioscrobbler.com/2.0/?method=album.getinfo&artist=#{escaped_artist}&album=#{escaped_title}&api_key=#{lastfm_key}&format=json"))
    unless query.key?('errors')
       return query.fetch('album').fetch('toptags').fetch('tag')[0].fetch('name')
    end
  end
end
