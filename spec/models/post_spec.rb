require 'rails_helper'
RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe '新規動画投稿' do
    context '新規投稿できる' do
      it '必要な情報が入力出来ていれば新規登録できる' do
        expect(@post).to be_valid
      end
    end
    context '新規投稿できない' do
      it '動画が空だと投稿できない' do
        @post.video = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Video can't be blank")
      end
      it 'industry_idが空だと投稿できない' do
        @post.industry_id = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("Industry can't be blank")
      end
      it 'industry_idが___だと投稿できない' do
        @post.industry_id = 1
        @post.valid?
        expect(@post.errors.full_messages).to include("Industry can't be blank")
      end
      it 'タイトルが空だと投稿できない' do
        @post.title = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("Title can't be blank")
      end
      it 'タイトルが50文字以上だと投稿できない' do
        @post.title = "abcdefghijklmnopqrstuvwkyzabcdefghijklmnopqrstuvwxyzabcdefghijklmn"
        @post.valid?
        expect(@post.errors.full_messages).to include("Title is too long (maximum is 50 characters)")
      end
      it '動画の詳細が空だと投稿できない' do
        @post.description = ""
        @post.valid?
        expect(@post.errors.full_messages).to include("Description can't be blank")
      end
      it 'user_idが紐づいていないと投稿できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("User must exist")
      end
    end
  end
end