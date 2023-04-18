class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :shipping_fee
  belongs_to :shipping_time

  validates :category, :condition, :prefecture, :shipping_fee, :shipping_time, :image, presence: true
  validates :category_id, :condition_id, :prefecture_id, :shipping_fee_id, :shipping_time_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :item_name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

end
