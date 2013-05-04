class User < ActiveRecord::Base

  include Clearance::User

  attr_accessible :username, :remember_token
  validates_format_of :username, with: /\A[a-z0-9_-]{2,19}\Z/i

  validate :limit_selection_count

  has_many :selections, limit: 9
  has_many :albums, through: :selections, order: 'created_at DESC'

  def limit_selection_count
    errors.add(:selections, "Too many selections") if vinyls.count > 9
  end

  def to_param
    username
  end

end
