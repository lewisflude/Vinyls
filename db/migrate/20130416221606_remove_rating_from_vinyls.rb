class RemoveRatingFromVinyls < ActiveRecord::Migration
  def change
    remove_column :vinyls, :rating
    remove_column :vinyls, :format
  end
end
