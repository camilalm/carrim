require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'when validating' do
    let(:cart) { described_class.new(total_price: -1) }

    it 'validates numericality of total_price' do
      expect(cart.valid?).to be_falsey
      expect(cart.errors[:total_price]).to include("must be greater than or equal to 0")
    end
  end

  describe 'mark_as_abandoned' do
    let(:shopping_cart) { create(:shopping_cart, last_interaction_at: last_interaction_at) }
    let(:limit_datetime) { 3.hours.ago }

    context 'when shopping cart last interaction is before limit' do
      let(:last_interaction_at) { limit_datetime - 1.minute }

      it 'marks as abandoned ' do
        expect { shopping_cart.mark_as_abandoned }.to change { shopping_cart.abandoned? }.from(false).to(true)
      end
    end

    context 'when shopping cart last interaction is after limit' do
      let(:last_interaction_at) { limit_datetime + 1.minute }

      it 'does not mark as abandoned' do
        shopping_cart.mark_as_abandoned
        expect(shopping_cart.abandoned).to be_falsey
      end
    end
  end

  describe 'remove_if_abandoned' do
    let(:shopping_cart) { create(:shopping_cart, last_interaction_at: last_interaction_at, abandoned: true) }
    let(:limit_datetime) { 7.days.ago }

    context 'when shopping cart was abandoned before limit' do
      let(:last_interaction_at) { limit_datetime - 1.minute }

      it 'removes the shopping cart' do
        shopping_cart.remove_if_abandoned
        expect(Cart.exists?(shopping_cart.id)).to be_falsey
      end
    end

    context 'when shopping cart was abandoned after limit' do
      let(:last_interaction_at) { limit_datetime + 1.minute }

      it 'does not remove the shopping cart' do
        shopping_cart.remove_if_abandoned
        expect(Cart.exists?(shopping_cart.id)).to be_truthy
      end
    end
  end
end
