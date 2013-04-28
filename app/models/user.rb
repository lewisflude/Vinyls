class User < ActiveRecord::Base

  include Clearance::User

  attr_accessible :username, :remember_token
  validates_format_of :username, with: /\A[a-z0-9_-]{2,19}\Z/i

  has_many :albums, order: 'created_at DESC'

  validates_each :albums do |user, attr, value|
    user.errors.add :base, "Can't add more than 9 albums. Remove one?" if user.albums.size >= 9
  end

  def to_param
    username
  end

end
