FactoryBot.define do
  factory :item do
    association :user
    item_name            { Faker::Lorem.word }
    description          { Faker::Lorem.sentence }
    category_id          { Faker::Number.between(from: 2, to: 11) }
    condition_id         { Faker::Number.between(from: 2, to: 7) }
    shipping_fee_id      { Faker::Number.between(from: 2, to: 3) }
    prefecture_id        { Faker::Number.between(from: 2, to: 48) }
    shipping_time_id     { Faker::Number.between(from: 2, to: 4) }
    price                { Faker::Number.between(from: 300, to: 9_999_999) }
    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/sample.png'), filename: 'sample.png', content_type: 'image/png')
    end
  end
end
