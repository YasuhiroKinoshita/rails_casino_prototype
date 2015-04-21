class CreateCashiers < ActiveRecord::Migration
  def change
    create_table :cashiers do |t|
      t.integer :organization_id
      t.integer :user_id
      t.integer :money

      t.timestamps
    end
  end
end
