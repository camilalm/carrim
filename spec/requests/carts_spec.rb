require 'rails_helper'

RSpec.describe "/carts", type: :request do
  pending "TODO: Escreva os testes de comportamento do controller de carrinho necessários para cobrir a sua implmentação #{__FILE__}"
  describe "POST /cart" do
    let(:valid_headers) { { 'Cookie' => "cart_id=#{cart.id}" } }
    let(:cart) { create(:cart) }
    let(:product) { create(:product, name: 'Test Product', price: 10.0) }
    let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 1) }

    context 'when the product already is in the cart' do
      subject do
        post '/cart', params: { product_id: product.id, quantity: 1 }, headers: valid_headers, as: :json
        post '/cart', params: { product_id: product.id, quantity: 1 }, headers: valid_headers, as: :json
      end

      it 'updates the quantity of the existing item in the cart' do
        expect { subject }.to change { cart_item.reload.quantity }.by(2)
      end

      it 'returns status created' do
        subject
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "POST /cart/add_item" do
    let(:valid_headers) { { 'Cookie' => "cart_id=#{cart.id}" } }
    let(:cart) { create(:cart) }
    let(:product) { create(:product, name: 'Test Product', price: 10.0) }
    let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 1) }

    context 'when the product already is in the cart' do
      subject do
        post '/cart/add_item', params: { product_id: product.id, quantity: 1 }, headers: valid_headers, as: :json
        post '/cart/add_item', params: { product_id: product.id, quantity: 1 }, headers: valid_headers, as: :json
      end

      it 'updates the quantity of the existing item in the cart' do
        expect { subject }.to change { cart_item.reload.quantity }.by(2)
      end

      it 'returns status created' do
        subject
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
