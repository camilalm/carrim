class CartsController < ApplicationController
  before_action :set_current_cart

  # POST /cart
  # POST /cart/add_item
  def add_item
    service = AddItemToCart.new(@current_cart, params)
    if service.perform
      render json: @current_cart, status: :created
    else
      render json: { error: 'error' }, status: :unprocessable_entity # TODO: melhorar mensagem erro
    end
  end
end
