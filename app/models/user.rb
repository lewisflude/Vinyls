class User < ActiveRecord::Base
  include Clearance::User
  attr_accessible :username

  has_many :vinyls, order: 'created_at DESC'

  validates_each :vinyls do |user, attr, value|
    user.errors.add :base, "Can't add more than 9 releases. Remove one?" if user.vinyls.size >= 9
  end

  def to_param
    username
  end

end
