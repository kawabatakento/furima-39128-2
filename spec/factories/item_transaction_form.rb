FactoryBot.define do
  factory :item_transaction_form do
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '札幌市' }
    address { '1-1' }
    building { 'ビル名' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
