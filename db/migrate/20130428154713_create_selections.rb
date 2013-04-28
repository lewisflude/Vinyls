class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.string :description
      t.integer :user_id
      t.integer :album_id
    end
  end
end
