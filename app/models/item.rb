class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :days
  belongs_to :prefecture
  belongs_to :user
  has_one_attached :image
  has_one :purchase

  with_options presence: true, numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :delivery_charge_id
    validates :status_id
    validates :days_id
    validates :prefecture_id
  end
  with_options presence: true do
    validates :description
    validates :items_name
    validates :image
  end
  validates :price, format: { with: /\A[0-9]+\z/ },
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }
end
