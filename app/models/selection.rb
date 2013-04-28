class Selection < ActiveRecord::Base

  attr_accessible :description, :album

  belongs_to :user
  belongs_to :album


end
