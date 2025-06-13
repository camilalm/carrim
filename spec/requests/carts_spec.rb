require 'rails_helper'

RSpec.describe "/carts", type: :request do
  pending "TODO: Escreva os testes de comportamento do controller de carrinho necessários para cobrir a sua implmentação #{__FILE__}"
  let(:valid_headers) { {} }
  let(:cart) { create(:cart, total_price: 10.0) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 1) }
  let(:product) { create(:product, name: 'Test Product', price: 10.0) }
  let(:parsed_json_response) { JSON.parse(response.body) }

  include_context 'session double'

  before { session_hash[:cart_id] = session_cart_id }

  describe 'GET /cart' do
    subject { get '/cart', headers: valid_headers, as: :json }

    context 'when there is no cart' do
      let(:session_cart_id) { nil }

      it 'returns status ok and cart data' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(parsed_json_response['id']).to be_present
        expect(parsed_json_response['products']).to be_empty
        expect(parsed_json_response['total_price']).to eq(0.0)
      end
    end

    context 'when exists cart' do
      let(:session_cart_id) { cart_item.cart_id }

      it 'returns status ok and cart data' do
        subject
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(parsed_json_response['id']).to be_present
        expect(parsed_json_response['products']).to be_present
        expect(parsed_json_response['total_price']).to eq(10.0)
      end
    end
  end

  describe "POST /cart" do
    context 'when the product already is in the cart' do
      let(:session_cart_id) { cart_item.cart_id }

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
    context 'when the product already is in the cart' do
      let(:session_cart_id) { cart_item.cart_id }

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
