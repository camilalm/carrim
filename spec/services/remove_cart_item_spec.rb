require 'rails_helper'

RSpec.describe RemoveCartItem do
  let(:service) { described_class.new(cart, product.id) }
  let(:cart) { create(:cart) }
  let(:product) { create(:product, price: 12.34) }
  let(:another_product) { create(:product, price: 5.1) }

  context 'when product is not in the cart' do
    it { expect(service.perform).to be_nil }
  end

  context 'when product is in the cart' do
    let!(:cart_item_product) { create(:cart_item, cart: cart, product: product, quantity: 3) }

    it 'removes cart item and updates cart total price' do
      expect(service.perform).to be_truthy
      expect(CartItem.find_by(id: cart_item_product.id)).to be_nil
      expect(cart.reload.total_price).to eq(0)
    end
  end

  context 'when product is in the cart and cart has other items' do
    let!(:cart_item_product) { create(:cart_item, cart: cart, product: product, quantity: 5) }
    let!(:cart_item_another_product) { create(:cart_item, cart: cart, product: another_product, quantity: 2) }
    let(:cart) { create(:cart) }

    it 'removes cart item and updates cart total price' do
      expect(service.perform).to be_truthy
      expect(CartItem.find_by(id: cart_item_product.id)).to be_nil
      expect(cart.reload.total_price).to eq(10.2)
    end
  end
end
