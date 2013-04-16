class Vinyl < ActiveRecord::Base

  attr_accessible :title, :artist, :genre, :format, :rating, :album_art
  has_attached_file :album_art, :styles => { 
    medium: "300x300!", 
    small: "150x150>",
    thumb: "229x229#" }, 
    storage: :s3, 
    s3_credentials: S3_CREDENTIALS,
    s3_host_name: "s3-eu-west-1.amazonaws.com",
    path: ":filename"

  validates_presence_of :title

  belongs_to :user
  delegate :email, :to => :user, :prefix => true

  def get_info_from_lastfm
  
    lastfm_key = ENV['LASTFM_KEY']
    lastfm_secret = ENV['LASTFM_SECRET']

    lastfm = Lastfm.new(lastfm_key, lastfm_secret)

    self.artist = lastfm.artist.search(self.artist)["results"]["artistmatches"]["artist"][0]

  end

end
