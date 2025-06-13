require 'rails_helper'

RSpec.describe UpdateCart do
  let(:service) { described_class.new(cart) }
  let(:cart) do
    product = create(:product, price: 12.34)
    another_product = create(:product, price: 5.1)
    cart = create(:cart, total_price: 0)
    cart_item_product = create(:cart_item, cart: cart, product: product, quantity: 3)
    cart_item_another_product = create(:cart_item, cart: cart, product: another_product, quantity: 5)
    cart
  end

  it { expect { service.perform }.to change { cart.reload.last_interaction_at } }

  it 'updates and calculates cart total price' do
    expect(service.perform).to be_truthy
    expect(cart.reload.total_price).to eq(62.52)
  end
end
