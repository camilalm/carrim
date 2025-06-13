class UpdateCart
  attr_reader :cart

  def initialize(cart)
    @cart = cart
  end

  def perform
    return if cart.blank?

    update_cart
    true
  end

  private

  def update_cart
    new_total_price = CalculateCartTotalPrice.new(cart).perform
    cart.update(total_price: new_total_price, last_interaction_at: Time.now)
  end
end
