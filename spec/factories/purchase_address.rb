FactoryBot.define do
  factory :purchase_address do
    phone_number                   { '00000000000' }
    postal_code                    { '123-1234' }
    prefecture_id                  { 2 }
    house_number                   { '2-5-2' }
    municipality                   { '足立区' }
    token                          { '0000000000000000' }
    building_name                  { 'テストマンション' }
  end
end
