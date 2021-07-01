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


## items テーブル

|Column|Type|Options|
|--------|-----|--------|
|items_name|string|null: false|
|category_id|integer|null: false|
|price|string|null: false|
|user|references|foreign_key: true|
|status_id|integer|null: false|
|delivery_charge_id|integer|null: false|
|prefectures_id|integer|null: false|
|days_id|integer|null: false|
|description|text|null: false|

## purchase テーブル

|Column|Type|Options|
|--------|-----|--------|
|user|references|foreign_key: true|
|item|references|foreign_key: true|

## shipping address テーブル

|Column|Type|Options|
|--------|-----|--------|
|purchase|references|foreign_key: true|
|postal_code|string|null: false|
|prefectures_id|integer|null: false|
|municipality|string|null: false|
|house_number|string|null: false|
|building_name|string|-------|
|phone_number|string|null: false|