# テーブル設計

## users テーブル

|Column|Type|Options|
|nickname|string|null: false|
|encrypted_password|string|null: false|
|birthday|date|null: false|
|email|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_nameカナ|string|null: false|
|last_nameカナ|string|null: false|


## items テーブル

|Column|Type|Options|
|items_name|string|null: false|
|category_id|integer|null: false|
|price|string|null: false|
|user_id|references|-------|
|status_id|integer|null: false|
|delivery_charge_id|integer|null: false|
|place|string|null: false|
|days_id|integer|null: false|
|description|text|null: false|

## purchase テーブル

|Column|Type|Options|
|user_id|references|-------|
|items_id|references|-------|

## shipping address テーブル

|Column|Type|Options|
|purchase_id|references|-------|
|postal_code|string|null: false|
|prefectures|integer|null: false|
|municipality|string|null: false|
|house_number|string|null: false|
|building_name|string|-------|
|phone_number|string|null: false|