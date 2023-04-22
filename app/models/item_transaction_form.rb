class ItemTransactionForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :shipping_address_attributes,
  :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token

  # 必須項目のバリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token

    # 配送先情報のバリデーション
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「3桁ハイフン4桁」の半角文字列で入力してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁以上11桁以内の半角数値で入力してください' }
  end

  def save
  
    ActiveRecord::Base.transaction do
      item_transaction = ItemTransaction.create!(user_id: user_id, item_id: item_id)
      ShippingAddress.create(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building: building,
        phone_number: phone_number,
        item_transaction_id: item_transaction.id
      )
    end
  end
end
