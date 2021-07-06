require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "ユーザー新規登録" do
    context '新規登録できるとき' do
      it '各必須項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it "emailが他のユーザーと重複していると登録できないこと" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it "emailには「@」を含む必要があること" do
        @user.email = 'hoge.com'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it "password_confirmationが空では登録できない" do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it "パスワードは、6文字以上での入力が必須であること" do
        @user.password = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end
      it "半角英語のみでは登録できない" do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it "半角数字のみでは登録できない" do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it "全角では登録できないこと" do
        @user.password = '００００００'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name is invalid"
      end
      it "first_nameが漢字・平仮名・片仮名以外だと登録できない" do
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include "First name is invalid"
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name is invalid"
      end
      it "last_nameが漢字・平仮名・片仮名以外だと登録できない" do
        @user.last_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name is invalid"
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana is invalid"
      end
      it "first_name_kanaが片仮名以外だと登録できない" do
        @user.first_name_kana = 'あ, a'
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana is invalid"
      end
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid"
      end
      it "last_name_kanaが片仮名以外だと登録できない" do
        @user.last_name_kana = 'あ, a'
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana is invalid"
      end
      it "birthdayが空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end