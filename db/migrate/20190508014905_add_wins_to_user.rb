class AddWinsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :wins, :integer
  end
end
