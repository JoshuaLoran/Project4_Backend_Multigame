class AddArrayToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :array, :json, array: true, default: []
  end
end
