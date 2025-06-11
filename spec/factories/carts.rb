FactoryBot.define do
  factory :cart do
    total_price { Faker::Commerce.price }
  end

  factory :shopping_cart, parent: :cart do
  end
end
