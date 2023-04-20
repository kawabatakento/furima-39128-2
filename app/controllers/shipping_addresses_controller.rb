class ShippingAddressesController < ApplicationController
  belongs_to :item_transaction

  validates :postal_code, presence: true, format: { with: /\A\d{3}[-]\d{4}\z/, message: "はハイフンを含めた半角数字7桁で入力してください。" }
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10}$|^\d{11}\z/, message: "は半角数字で入力してください。ハイフンなしで入力してください。" }
end