class ApplicationController < ActionController::API
  include ActionController::Cookies

  private

  def set_current_cart
    @current_cart = FindOrCreateCart.new(cookies[:cart_id]).perform
    cookies[:cart_id] = @current_cart.id unless cookies[:cart_id]
  end
end
