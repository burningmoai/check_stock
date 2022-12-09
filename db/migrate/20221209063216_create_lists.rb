class CreateLists < ActiveRecord::Migration[6.1]
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.integer :food_id
      t.integer :amount
      t.string :unit

      t.timestamps
    end
  end
end
