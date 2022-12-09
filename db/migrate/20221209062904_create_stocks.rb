class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.integer :user_id
      t.integer :food_id
      t.integer :amount
      t.string :unit
      t.datetime :buy_day
      t.datetime :limit
      t.text :memo

      t.timestamps
    end
  end
end
