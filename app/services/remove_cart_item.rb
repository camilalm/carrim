class RemoveCartItem
  attr_reader :cart, :product_id

  def initialize(cart, product_id)
    @cart = cart
    @product_id = product_id
  end

  def perform
    return if cart.blank?
    return if product_id.blank?
    return if cart_item.blank?

    remove_cart_item
    update_cart
    true
  end

  private

  def remove_cart_item
    cart_item.destroy!
  end

  def update_cart
    UpdateCart.new(cart).perform
  end

  def cart_item
    @cart_item ||= cart.cart_items.find_by(product_id: product_id)
  end
end
