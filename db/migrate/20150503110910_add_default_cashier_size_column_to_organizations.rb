class AddDefaultCashierSizeColumnToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :default_cashier_size, :integer
  end
end
