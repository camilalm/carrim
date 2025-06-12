require 'rails_helper'

RSpec.describe FindOrCreateCart do
  let(:service) { described_class.new(cart_id) }

  context 'when cart_id informed does not exist' do
    let(:cart_id) { 1 }

    it 'returns true and creates new cart' do
      expect(service.perform).to be_truthy
      expect(Cart.count).to eq(1)
      expect(service.cart).to be_present
    end
  end

  context 'when cart_id informed exists' do
    let!(:cart) { create(:cart) }
    let(:cart_id) { cart.id }

    it 'returns true and find cart' do
      expect(service.perform).to be_truthy
      expect(Cart.count).to eq(1)
      expect(service.cart).to be_present
      expect(service.cart.id).to eq(cart_id)
    end
  end

  context 'when cart_id informed is nil' do
    let(:cart_id) { nil }

    it 'returns true and creates new cart' do
      expect(service.perform).to be_truthy
      expect(Cart.count).to eq(1)
      expect(service.cart).to be_present
    end
  end
end
