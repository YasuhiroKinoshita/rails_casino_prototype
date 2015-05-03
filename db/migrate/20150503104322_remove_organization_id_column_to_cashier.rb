class RemoveOrganizationIdColumnToCashier < ActiveRecord::Migration
  def change
    remove_column :cashiers, :organization_id, :integer
  end
end
