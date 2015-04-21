class AddOrganizationIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :organization_id, :integer
  end
end
