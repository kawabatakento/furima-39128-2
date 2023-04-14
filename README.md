# テーブル設計

## users テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name     | string     | null: false                    |
| email        | string     | null: false                    |
| password     | string     | null: false                    |
| address      | string     | null: false                    |
| phone_number | string     | null: false                    |

- has_many :items
- has_many :transactions

## items テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| item_name      | string     | null: false                    |
| description    | text       | null: false                    |
| price          | integer    | null: false                    |
| category_id    | references | null: false, foreign_key: true |
| seller_id      | references | null: false, foreign_key: true |
| condition      | string     | null: false                    |
| stock          | integer    | null: false                    |
| image          | string     | null: true                     |

- belongs_to :user
- belongs_to :category
- has_one :transaction


## categories テーブル

| Column         | Type    | Options     |
| -------------- | ------- | ----------- |
| category_name  | string  | null: false |

- has_many :items


## transactions テーブル（商品購入機能）

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
| transaction        | references | null: false, foreign_key: true |

- belongs_to :transaction