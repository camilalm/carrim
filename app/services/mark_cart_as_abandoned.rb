class MarkCartAsAbandoned
  attr_reader :cart_id

  def initialize(cart_id)
    @cart_id = cart_id
  end

  def perform
    return if cart.blank?

    cart.mark_as_abandoned
  end

  private

  def cart
    @cart ||= Cart.find_by(id: cart_id)
  end
end

