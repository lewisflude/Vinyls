class Vinyl < ActiveRecord::Base

  attr_accessible :title, :artist, :genre, :format, :rating, :album_art
  
  has_attached_file :album_art, :styles => { 
    medium: "300x300!", 
    small: "150x150>",
    thumb: "250x250#" }, 
    dependent: :destroy,
    storage: :s3, 
    s3_credentials: S3_CREDENTIALS,
    s3_host_name: "s3-eu-west-1.amazonaws.com",
    path: ":filename"

  validates_presence_of :title, :artist
  validates_attachment_presence :album_art
  validates_attachment_size :album_art, :less_than => 10.megabytes

  belongs_to :user
  validates_associated :user, :message => "You already have 9 vinyls."
  delegate :email, :to => :user, :prefix => true

  # def get_info_from_lastfm
  #   lastfm_key = ENV['LASTFM_KEY']
  #   lastfm_secret = ENV['LASTFM_SECRET']
  #   lastfm = Lastfm.new(lastfm_key, lastfm_secret)
  #   self.artist = lastfm.artist.search(self.artist)["results"]["artistmatches"]["artist"][0]
  # end

  def get_album_art_from_discogs

    # discogs_key = ENV['DISCOGS_KEY']
    # discogs_secret = ENV['DISCOGS_SECRET']

    wrapper = Discogs::Wrapper.new("Vinyls.me")
    search = wrapper.search(self.name + " " + self.title, type: "master", title: true, release_title: true)

  end

end
