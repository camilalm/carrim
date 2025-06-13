class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :name, :unit_price, :total_price

  def id
    object.product_id
  end

  def name
    object.product_name
  end

  def unit_price
    object.product_price.to_f
  end

  def total_price
    (object.product_price * object.quantity).to_f
  end
end
