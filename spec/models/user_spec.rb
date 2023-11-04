require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる' do
      it '必要な情報が入力出来ていれば新規登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録出来ない' do
      it 'usernameが空では登録出来ない' do
        @user.username = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Username can't be blank")
      end
      it 'usernameに数字が含まれていると登録出来ない' do
        @user.username = "123asd"
        @user.valid?
        expect(@user.errors.full_messages).to include("Username only accepts English letters, Hiragana, Katakana, and Kanji")
      end
      it 'emailが空では登録出来ない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailには@が含まれていない登録出来ない' do
        @user.email = "aaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it '重複したemailが存在しては登録出来ない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'passwordが空では登録出来ない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが15文字以下では登録出来ない' do
        @user.password = "1234aaaiiA"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 16 characters)")
      end
      it 'passwordが英字しか存在しない場合は登録出来ない' do
        @user.password = "abcdefgaaadddewqq"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordが数字しか存在しない場合は登録出来ない'do
        @user.password = "123456789012345678"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordとpassword_confirmationが一致していないと登録出来ない' do
        @user.password = '1234'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end