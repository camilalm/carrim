class UpdateCart
  attr_reader :cart

  def initialize(cart)
    @cart = cart
  end

  def perform
    return if cart.blank?

    update_cart
    schedule_mark_as_abandoned
    true
  end

  private

  def update_cart
    new_total_price = CalculateCartTotalPrice.new(cart).perform
    cart.update(total_price: new_total_price, last_interaction_at: Time.now)
  end

  def schedule_mark_as_abandoned
    MarkCartAsAbandonedWorker.perform_in(3.hours, cart.id)
  end
end
