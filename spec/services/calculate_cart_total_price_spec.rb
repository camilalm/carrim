require 'rails_helper'

RSpec.describe CalculateCartTotalPrice do
  let(:service) { described_class.new(cart) }
  let(:cart) { create(:cart) }
  let(:product) { create(:product, price: 12.34) }
  let(:another_product) { create(:product, price: 5.1) }

  context 'when cart is empty' do
    it { expect(service.perform).to eq(0) }
  end

  context 'when there is a product at cart' do
    let!(:cart_item_product) { create(:cart_item, cart: cart, product: product, quantity: 3) }

    it { expect(service.perform).to eq(37.02) }
  end

  context 'when cart has other items' do
    let!(:cart_item_product) { create(:cart_item, cart: cart, product: product, quantity: 5) }
    let!(:cart_item_another_product) { create(:cart_item, cart: cart, product: another_product, quantity: 2) }
    let(:cart) { create(:cart) }

    it { expect(service.perform).to eq(71.9) }
  end
end
