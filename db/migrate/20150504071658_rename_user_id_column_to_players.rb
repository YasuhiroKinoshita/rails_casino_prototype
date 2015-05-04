class RenameUserIdColumnToPlayers < ActiveRecord::Migration
  def change
    rename_column :players, :user_id, :member_id
  end
end
