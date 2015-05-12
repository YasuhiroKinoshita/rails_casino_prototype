class RemoveMoneyChangesColumnFromGameStatus < ActiveRecord::Migration
  def change
    remove_column :game_statuses, :money_changes, :integer
  end
end
