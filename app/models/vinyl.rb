class Vinyl < ActiveRecord::Base

  attr_accessible :title, :artist, :genre, :format, :rating, :album_art, :user_id
  has_attached_file :album_art, :styles => { 
  :medium => "300x300>", 
  :thumb => "100x100>" }, 
  :storage => :s3, 
  :s3_credentials => S3_CREDENTIALS,
  :s3_host_name  => "s3-eu-west-1.amazonaws.com",
  :path => ":filename"


  validates_presence_of :title

  belongs_to :user
  delegate :email, :to => :user, :prefix => true

end
