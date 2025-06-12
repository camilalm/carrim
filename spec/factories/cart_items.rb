FactoryBot.define do
  factory :cart_item do
    cart { build(:cart) }
    product { build(:product) }
    quantity { Faker::Number.within(range: 1..10) }
  end
end
