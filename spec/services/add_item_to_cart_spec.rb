require 'rails_helper'

RSpec.describe AddItemToCart do
  let(:service) { described_class.new(cart, params) }
  let(:product) { create(:product, price: 12.34) }
  let(:another_product) { create(:product, price: 5.1) }
  let(:params) { { product_id: product.id, quantity: 4 } }

  context 'when cart is empty' do
    let(:cart) { create(:cart, total_price: 0) }

    it { expect { service.perform }.to change { cart.reload.last_interaction_at } }

    it 'creates cart item' do
      expect(service.perform).to be_truthy

      cart.reload
      expect(cart.cart_items.count).to eq(1)

      cart_item = cart.cart_items.take
      expect(cart_item.product_id).to eq(product.id)
      expect(cart_item.quantity).to eq(4)
    end

    it 'updates cart total price' do
      service.perform

      expect(cart.total_price).to eq(49.36)
    end
  end

  context 'when product is already at cart' do
    let!(:cart_item_product) { create(:cart_item, cart: cart, product: product, quantity: 3) }
    let(:cart) { create(:cart, total_price: 37.02) }

    it { expect { service.perform }.to change { cart.reload.last_interaction_at } }

    it 'updates cart item quantity' do
      expect(service.perform).to be_truthy

      cart.reload
      expect(cart.cart_items.count).to eq(1)
      expect(cart_item_product.reload.quantity).to eq(7)
      expect(cart.total_price).to eq(86.38)
    end
  end

  context 'when cart has other items' do
    let!(:cart_item_product) { create(:cart_item, cart: cart, product: product, quantity: 5) }
    let!(:cart_item_another_product) { create(:cart_item, cart: cart, product: another_product, quantity: 2) }
    let(:cart) { create(:cart, total_price: 71.9) }

    it { expect { service.perform }.to change { cart.reload.last_interaction_at } }

    it 'updates cart item quantity to product informed' do
      expect(service.perform).to be_truthy

      cart.reload
      expect(cart.cart_items.count).to eq(2)
      expect(cart_item_product.reload.quantity).to eq(9)
      expect(cart_item_another_product.reload.quantity).to eq(2)
      expect(cart.total_price).to eq(121.26)
    end
  end
end
