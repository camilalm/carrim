require 'rails_helper'

RSpec.describe "/carts", type: :request do
  pending "TODO: Escreva os testes de comportamento do controller de carrinho necessários para cobrir a sua implmentação #{__FILE__}"
  describe "POST /add_item" do
    let(:valid_headers) { {} }
    let(:cart) { create(:cart) }
    let(:product) { create(:product, name: 'Test Product', price: 10.0) }
    let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 1) }

    context 'when the product already is in the cart' do
      # TODO: continue
      # it 'updates the quantity of the existing item in the cart' do
      #   post '/cart/add_items', params: { product_id: product.id, quantity: 1 }, headers: valid_headers, as: :json
      #   post '/cart/add_items', params: { product_id: product.id, quantity: 1 }, headers: valid_headers, as: :json

      #   expect(cart_item.reload.quantity).to eq(3)
      # end

      it 'returns status created' do
        post '/cart/add_item', params: { product_id: product.id, quantity: 1 }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
