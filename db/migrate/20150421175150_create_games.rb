class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.integer :buy_in

      t.timestamps
    end
  end
end
