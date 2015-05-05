class CreateGameStatuses < ActiveRecord::Migration
  def change
    create_table :game_statuses do |t|
      t.integer :player_id
      t.integer :status
      t.integer :money_changes

      t.timestamps
    end
  end
end
