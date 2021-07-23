# テーブル設計

## users テーブル

|Column|Type|Options|
|--------|-----|--------|
|nickname|string|null: false|
|encrypted_password|string|null: false|
|birthday|date|null: false|
|email|string|null: false,unique: true|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|

### Association
- has_many :items
- has_many :purchases

## items テーブル

|Column|Type|Options|
|--------|-----|--------|
|items_name|string|null: false|
|category_id|integer|null: false|
|price|integer|null: false|
|user|references|foreign_key: true|
|status_id|integer|null: false|
|delivery_charge_id|integer|null: false|
|prefecture_id|integer|null: false|
|days_id|integer|null: false|
|description|text|null: false|

### Association
- belongs_to :user
- has_one :purchase


## purchase テーブル

|Column|Type|Options|
|--------|-----|--------|
|user|references|foreign_key: true|
|item|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_address テーブル

|Column|Type|Options|
|--------|-----|--------|
|purchase|references|foreign_key: true|
|postal_code|string|null: false|
|prefecture_id|integer|null: false|
|municipality|string|null: false|
|house_number|string|null: false|
|building_name|string|-------|
|phone_number|string|null: false|

### Association
- belongs_to :purchase