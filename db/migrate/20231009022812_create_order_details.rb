class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.string :product_name
      t.integer :quantity
      t.text :description
      t.decimal :price
      t.date :order_date

      t.timestamps
    end
  end
end
