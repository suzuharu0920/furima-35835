class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :phone_number, :postal_code, :purchase_id, :prefecture_id, :house_number,
                :municipality, :building_name

  with_options presence: true do
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :token
    validates :user_id
    validates :item_id
    validates :house_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is too short' }
    validates :municipality
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create!(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality,
                            house_number: house_number, phone_number: phone_number, building_name: building_name, purchase_id: purchase.id)
  end
end
