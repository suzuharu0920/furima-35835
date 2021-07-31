require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品登録' do
    context '商品登録できるとき' do
      it '各必須項目が正しく入力されていれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '商品登録ができない時' do
      it '画像が空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "画像を入力してください"
      end
      it '商品名が空だと登録できない' do
        @item.items_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end
      it 'カテゴリーが選択されていないと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーを選択してください"
      end
      it '商品の状態が選択されていないと登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の状態を選択してください"
      end
      it '配送料の負担が選択されていないと登録できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料の負担を選択してください"
      end
      it '発送元の地域が選択されていないと登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "発送元の地域を選択してください"
      end
      it '発送までの日数が選択されていないと登録できない' do
        @item.days_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数を選択してください"
      end
      it '価格が空白だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は300円〜9999999円(半角数字)で入力してください'
      end
      it '価格は全角文字では登録できない' do
        @item.price = 'あいう１２３'
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は300円〜9999999円(半角数字)で入力してください'
      end
      it '価格は半角英数混合では登録できない' do
        @item.price = 'abc123'
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は300円〜9999999円(半角数字)で入力してください'
      end
      it '価格は半角英語だけでは登録できない' do
        @item.price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は300円〜9999999円(半角数字)で入力してください'
      end
      it '価格は299円以下では登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は300円〜9999999円(半角数字)で入力してください'
      end
      it '価格は10,000,000以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include '価格は300円〜9999999円(半角数字)で入力してください'
      end
      it 'userが紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
