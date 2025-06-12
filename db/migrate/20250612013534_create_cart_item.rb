class CreateCartItem < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, index: true
      t.references :product, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
