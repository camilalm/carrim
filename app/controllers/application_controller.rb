class ApplicationController < ActionController::API
  private

  def set_current_cart
    @current_cart = FindOrCreateCart.new(session[:cart_id]).perform
    session[:cart_id] = @current_cart.id unless session[:cart_id]
  end
end
