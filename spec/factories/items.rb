FactoryBot.define do
  factory :item do
    association :user
    items_name                 { '商品名（必須 40文字まで)' }
    description                { '商品の詳細(必須 1000文字まで)' }
    category_id                { 2 }
    status_id                  { 2 }
    delivery_charge_id         { 2 }
    prefecture_id              { 2 }
    days_id                    { 2 }
    price                      { 300 }

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/image2.jpeg'), filename: 'image2.jpeg')
    end
  end
end
