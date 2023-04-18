FactoryBot.define do
  factory :item do
    association :user
    item_name            { Faker::Lorem.word }
    description          { Faker::Lorem.sentence }
    category_id          { Faker::Number.between(from: 1, to: 10) }
    condition_id         { Faker::Number.between(from: 1, to: 6) }
    shipping_fee_id      { Faker::Number.between(from: 1, to: 2) }
    prefecture_id        { Faker::Number.between(from: 1, to: 48) }
    shipping_time_id     { Faker::Number.between(from: 1, to: 3) }
    price                { Faker::Number.between(from: 300, to: 9_999_999) }
    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/sample.png'), filename: 'sample.png', content_type: 'image/png')
    end
  end
end
