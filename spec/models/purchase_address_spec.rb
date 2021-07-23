require 'rails_helper'
RSpec.describe PurchaseAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id)
  end
  describe '商品購入機能' do
    context '商品購入ができるとき' do
      it '各必須項目が正しく入力されていれば登録できる' do
        expect(@purchase_address).to be_valid
      end
      it '建物名が空でも登録できる' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
    end
    context '商品購入ができないとき' do
      it 'tokenが空だと登録できない' do
        @purchase_address.token = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Token can't be blank"
      end
      it 'phone_numberが空だと登録できない' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Phone number can't be blank"
      end
      it 'postal_codeが空だと登録できない' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Postal code can't be blank"
      end
      it 'prefectureが選択されていないと登録できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'house_numberが空だと登録できない' do
        @purchase_address.house_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "House number can't be blank"
      end
      it 'municipalityが空だと登録できない' do
        @purchase_address.municipality = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Municipality can't be blank"
      end
      it 'phone_numberが10桁以上11桁以内でないと保存できないこと' do
        @purchase_address.phone_number = '111111111'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include 'Phone number is too short'
      end
      it 'postal_codeに-がないと登録できない' do
        @purchase_address.postal_code = '123123'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it 'postal_codeが半角文字列のみでないと登録できないこと' do
        @purchase_address.postal_code = '１２３−１２３４'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include 'Postal code is invalid. Include hyphen(-)'
      end
      it 'phone_numberは英数混合では登録できないこと' do
        @purchase_address.phone_number = 'abcde123456'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include 'Phone number is too short'
      end
      it 'user_idが空では購入できないこと' do
        @purchase_address.user_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "User can't be blank"
      end
      it 'item_idが空では購入できないこと' do
        @purchase_address.item_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Item can't be blank"
      end
    end
  end
end
