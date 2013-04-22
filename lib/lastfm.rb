require 'rest_client'
require 'json'

class Lastfm
 
  def fetch_album_art(query)
    escaped_title = URI::escape(query)
    lastfm_key = ENV["LASTFM_KEY"]
    album = RestClient.get("http://ws.audioscrobbler.com/2.0/?method=album.search&album=#{escaped_title}&api_key=#{lastfm_key}&format=json")
    results = JSON.parse(album).fetch('results').fetch('albummatches').fetch('album')[0].fetch('image').last.fetch('#text')
  end
end
