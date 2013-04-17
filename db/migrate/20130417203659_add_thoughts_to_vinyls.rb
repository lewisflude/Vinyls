class AddThoughtsToVinyls < ActiveRecord::Migration
  def change
    add_column :vinyls, :thoughts, :string
  end
end
