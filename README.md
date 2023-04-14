# テーブル設計

## users テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| nickname     | string     | null: false                    |
| email        | string     | null: false,unique:true        |
| encrypted_password        | string     | null: false                    |
| last_name       | string | null: false                    |
| first_name      | string | null: false                    |
| last_name_kana  | string | null: false                    |
| first_name_kana | string | null: false                    |
| birth_date      | date   | null: false                    |

- has_many :items
- has_many :item_transactions

## items テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| item_name                | string     | null: false                    |
| description         | text       | null: false                    |
| category_id         | integer    | null: false                    |
| condition_id        | integer    | null: false                    |
| shipping_fee_id     | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| shipping_time_id    | integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

- belongs_to :user
- has_one :item_transaction

## comments テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| item     | references | null: false, foreign_key: true |
| content  | text       | null: false                    |

- belongs_to :user
- belongs_to :item

## item_transactions テーブル（商品購入機能）

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses テーブル（配送先住所）

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| address            | string     | null: false                    |
| building           | string     |                                |
| phone_number       | string     | null: false                    |
| item_transaction   | references | null: false, foreign_key: true |

- belongs_to :item_transaction