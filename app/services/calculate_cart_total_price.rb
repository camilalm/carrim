class CalculateCartTotalPrice
  attr_reader :cart

  def initialize(cart)
    @cart = cart
  end

  def perform
    calculate_total_price
  end

  private

  def calculate_total_price
    cart.cart_items.sum { |item| item.quantity * item.product_price }
  end
end
