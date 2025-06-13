class CartsController < ApplicationController
  before_action :set_current_cart

  # GET /cart
  def show
    render json: @current_cart
  end

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

  # DELETE /cart/:product_id
  def remove_cart_item
    product_id = params[:product_id].to_i
    if @current_cart.product_ids.include?(product_id)
      service = RemoveCartItem.new(@current_cart, product_id)
      if service.perform
        render json: @current_cart, status: :ok
      else
        render json: { error: 'error' }, status: :unprocessable_entity # TODO: melhorar mensagem erro
      end
    else
      render json: { error: 'Produto informado não está no carrinho' }, status: :not_found # TODO: i18n
    end
  end
end
