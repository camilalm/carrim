class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :name, :unit_price, :total_price

  def name
    object.product_name
  end

  def unit_price
    object.product_price
  end

  def total_price
    object.product_price * object.quantity
  end
end
