class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :price, null: false
      t.text :text, null: false
      t.timestamps
    end
  end
end
