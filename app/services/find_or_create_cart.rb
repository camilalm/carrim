class FindOrCreateCart
  attr_reader :cart_id, :cart

  def initialize(cart_id)
    @cart_id = cart_id
  end

  def perform
    @cart ||= find_cart || create_new_cart
  end

  private

  def find_cart
    Cart.find_by(id: cart_id)
  end

  def create_new_cart
    Cart.create(total_price: 0)
  end
end
