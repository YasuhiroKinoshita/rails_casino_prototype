class RenameUserIdColumnToCashiers < ActiveRecord::Migration
  def up
    rename_column :cashiers, :user_id, :member_id
  end

  def down
    rename_column :cashiers, :member_id, :user_id
  end
end
