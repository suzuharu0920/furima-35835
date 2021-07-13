FactoryBot.define do
  factory :item do
    association :user
    items_name                 { "商品名（必須 40文字まで)" }
    description                { "商品の詳細(必須 1000文字まで)" }
    category_id                { 1 }
    status_id                  { 1 }
    delivery_charge_id         { 1 }
    prefecture_id              { 1 }
    days_id                    { 1 }
    price                      { 300 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/image2.jpeg'), filename: 'image2.jpeg')
    end
  end
end
