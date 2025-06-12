require 'rails_helper'

RSpec.describe AddItemToCart do
  let(:service) { described_class.new(cart, params) }
  let(:product) { create(:product) }
  let(:another_product) { create(:product) }
  let(:cart) { create(:cart) }
  let(:params) { { product_id: product.id, quantity: 4 } }

  context 'when cart is empty' do
    it 'creates cart item' do
      expect(service.perform).to be_truthy

      cart.reload
      expect(cart.cart_items.count).to eq(1)

      cart_item = cart.cart_items.take
      expect(cart_item.product_id).to eq(product.id)
      expect(cart_item.quantity).to eq(4)
    end
  end

  context 'when product is already at cart' do
    let!(:cart_item_product) { create(:cart_item, cart: cart, product: product, quantity: 3) }

    it 'updates cart item quantity' do
      expect(service.perform).to be_truthy

      cart.reload
      expect(cart.cart_items.count).to eq(1)
      expect(cart_item_product.reload.quantity).to eq(7)
    end
  end

  context 'when cart has other items' do
    let!(:cart_item_product) { create(:cart_item, cart: cart, product: product, quantity: 5) }
    let!(:cart_item_another_product) { create(:cart_item, cart: cart, product: another_product, quantity: 2) }

    it 'updates cart item quantity to product informed' do
      expect(service.perform).to be_truthy

      cart.reload
      expect(cart.cart_items.count).to eq(2)
      expect(cart_item_product.reload.quantity).to eq(9)
      expect(cart_item_another_product.reload.quantity).to eq(2)
    end
  end
end
