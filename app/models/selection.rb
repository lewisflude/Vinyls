class Selection < ActiveRecord::Base

  attr_accessible :descripion

  belongs_to :user
  belongs_to :album

end
