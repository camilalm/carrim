FactoryBot.define do
  factory :cart do
    total_price { Faker::Commerce.price }
    last_interaction_at { Time.now }
  end

  factory :shopping_cart, parent: :cart do
  end
end
