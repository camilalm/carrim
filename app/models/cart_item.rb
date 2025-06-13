class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  delegate :name, :price, to: :product, prefix: true
end
