class AddIsClosedColumnToGame < ActiveRecord::Migration
  def change
    add_column :games, :is_closed, :boolean, default: false
  end
end
