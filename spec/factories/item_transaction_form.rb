FactoryBot.define do
  factory :item_transaction_form do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '札幌市' }
    address { '1-1' }
    building { 'ビル名' }
    phone_number { '09012345678' }
    user_id { 1 }
    item_id { 1 }
    token { 'tok_abcdefghijk00000000000000000' }

    # 必要に応じて、アソシエーションを設定します。
    # association :user
    # association :item
  end
end
