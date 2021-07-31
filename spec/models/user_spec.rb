require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '各必須項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'Eメールが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Eメールを入力してください"
      end
      it 'Eメールが他のユーザーと重複していると登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'Eメールには「@」を含む必要があること' do
        @user.email = 'hoge.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Eメールは不正な値です'
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it 'パスワード（確認用）が空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは6文字以上で入力してください'
      end
      it 'パスワードは半角英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは不正な値です'
      end
      it 'パスワードは半角数字のみでは登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは不正な値です'
      end
      it 'パスワードは全角では登録できないこと' do
        @user.password = '００００００'
        @user.valid?
        expect(@user.errors.full_messages).to include 'パスワードは不正な値です'
      end
      it '名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '名前を入力してください'
      end
      it '名前が漢字・平仮名・片仮名以外だと登録できない' do
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include '名前は不正な値です'
      end
      it '苗字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '苗字を入力してください'
      end
      it '苗字が漢字・平仮名・片仮名以外だと登録できない' do
        @user.last_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include '苗字は不正な値です'
      end
      it '名前カナが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '名前カナを入力してください'
      end
      it '名前カナが片仮名以外だと登録できない' do
        @user.first_name_kana = 'あ, a'
        @user.valid?
        expect(@user.errors.full_messages).to include '名前カナは不正な値です'
      end
      it '苗字カナが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include '苗字カナを入力してください'
      end
      it '苗字カナが片仮名以外だと登録できない' do
        @user.last_name_kana = 'あ, a'
        @user.valid?
        expect(@user.errors.full_messages).to include '苗字カナは不正な値です'
      end
      it '誕生日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "誕生日を入力してください"
      end
    end
  end
end
