class AddItemToCart
  attr_reader :cart, :product_id, :quantity

  def initialize(cart, params)
    @cart = cart
    @product_id = params[:product_id].to_i
    @quantity = params[:quantity].to_i
  end

  def perform
    return if cart.blank?
    return if product_id.blank?
    return if quantity.blank?

    update_cart_item
  end

  private

  def update_cart_item
    cart_item.update(quantity: cart_item.quantity + quantity)
  end

  def cart_item
    @cart_item ||= find_cart_item || create_cart_item
  end

  def find_cart_item
    cart.cart_items.find_by(product_id: product_id)
  end

  def create_cart_item
    CartItem.create(cart: cart, product_id: product_id, quantity: 0)
  end
end
