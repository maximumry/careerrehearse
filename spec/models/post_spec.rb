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
      it 'が空だと投稿できない' do
        @post.video = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("Video can't be blank")
      end
  end
end