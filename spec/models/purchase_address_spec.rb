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
      it 'クレジットカード情報が空だと登録できない' do
        @purchase_address.token = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "クレジットカード情報を入力してください"
      end
      it '電話番号が空だと登録できない' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "電話番号を入力してください"
      end
      it '郵便番号が空だと登録できない' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "郵便番号を入力してください"
      end
      it '都道府県が選択されていないと登録できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "都道府県を選択してください"
      end
      it '番地が空だと登録できない' do
        @purchase_address.house_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "番地を入力してください"
      end
      it '市区町村が空だと登録できない' do
        @purchase_address.municipality = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "市区町村を入力してください"
      end
      it '電話番号が10桁以上11桁以内でないと保存できないこと' do
        @purchase_address.phone_number = '111111111'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '電話番号は10〜11字の半角数字で入力してください'
      end
      it '郵便番号に-がないと登録できない' do
        @purchase_address.postal_code = '123123'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '郵便番号はハイフンを含む半角数字で入力してください'
      end
      it '郵便番号が半角文字列のみでないと登録できないこと' do
        @purchase_address.postal_code = '１２３−１２３４'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '郵便番号はハイフンを含む半角数字で入力してください'
      end
      it '電話番号は英数混合では登録できないこと' do
        @purchase_address.phone_number = 'abcde123456'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include '電話番号は10〜11字の半角数字で入力してください'
      end
      it 'user_idが空では購入できないこと' do
        @purchase_address.user_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Userを入力してください"
      end
      it 'item_idが空では購入できないこと' do
        @purchase_address.item_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Itemを入力してください"
      end
    end
  end
end
