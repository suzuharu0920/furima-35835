require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe "商品出品登録" do
    context '商品登録できるとき' do
      it '各必須項目が正しく入力されていれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '商品登録ができない時' do
      it "item_nameが空だと登録できない" do
        @item.items_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Items name can't be blank"
      end
      it "categoryが選択されていないと登録できない" do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it "statusが選択されていないと登録できない" do
        @item.status_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Status can't be blank"
      end
      it "delivery_chargeが選択されていないと登録できない" do
        @item.delivery_charge_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery charge can't be blank"
      end
      it "prefectureが選択されていないと登録できない" do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it "daysが選択されていないと登録できない" do
        @item.days_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Days can't be blank"
      end
      it "priceが空白だと登録できない" do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is out of setting range"
      end
    end
  end
end
