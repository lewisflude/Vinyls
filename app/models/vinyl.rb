class Vinyl < ActiveRecord::Base

  attr_accessible :title, :artist, :genre, :format, :rating

  validates_presence_of :title

end
