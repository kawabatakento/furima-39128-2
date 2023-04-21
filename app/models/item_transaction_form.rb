class ItemTransactionForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :shipping_address_attributes, :card_number, :exp_month, :exp_year, :cvc

  # 必須項目のバリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id

    # 配送先情報のバリデーション
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'は「3桁ハイフン4桁」の半角文字列で入力してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁以上11桁以内の半角数値で入力してください' }
  end

  # 建物名は任意
  validates :building

  # クレジットカード情報のバリデーション
  validates :card_number, presence: true, format: { with: /\A\d{16}\z/, message: 'は16桁の半角数字で入力してください' }
  validates :exp_month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12, message: 'は1~12の範囲で入力してください' }
  validates :exp_year, presence: true, numericality: { greater_than_or_equal_to: Date.today.year % 100, message: 'は今日より未来の日付で入力してください' }
  validates :cvc, presence: true, format: { with: /\A\d{3,4}\z/, message: 'は3桁もしくは4桁の半角数字で入力してください' }


  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      item_transaction = ItemTransaction.create!(user_id: user_id, item_id: item_id)
      ShippingAddress.create!(shipping_address_attributes.merge(item_transaction_id: item_transaction.id))
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end
