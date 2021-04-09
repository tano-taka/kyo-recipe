require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @recipe = FactoryBot.build(:recipe)
  end
  
  describe 'レシピ新規投稿' do
    context '新規投稿がうまくいく時' do
      it '画像があり全て項目が埋められていれば登録ができる' do
        expect(@recipe).to be_valid
      end
      it 'procedure2がなくても登録できる' do
        @recipe.procedure2 = "" 
        expect(@recipe).to be_valid
      end
      it 'procedure3がなくても登録できる' do
        @recipe.procedure3 = "" 
        expect(@recipe).to be_valid
      end
      it 'infoがなくても登録できる' do
        @recipe.info = "" 
        expect(@recipe).to be_valid
      end
    end

    context '新規投稿がうなくいかない時' do
      it '画像がないと登録できない' do
        @recipe.image = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Image can't be blank")
      end
      it 'タイトルがないと登録できない' do
        @recipe.title = ''
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Title can't be blank")
      end
      it 'タイトルが20文字を超えると登録できない' do
        @recipe.title = 'あ' * 21
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Title is too long (maximum is 20 characters)")
      end
      it '値段がないと登録できない' do
        @recipe.price = ''
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Price can't be blank")
      end
      it '値段が0円以下だと登録できない' do
        @recipe.price = 0
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Price Out of setting range")
      end
      it '値段が2001円以上だと登録できない' do
        @recipe.price = 2001
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Price Out of setting range")
      end
      it '値段が文字だと登録できない' do
        @recipe.price = "テスト"
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Price Out of setting range")
      end
      it 'procedure1がないと登録できない' do
        @recipe.procedure1 = ''
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Procedure1 can't be blank")
      end
      it 'procedure1が50文字を超えると登録できない' do
        @recipe.procedure1 = 'あ' * 51
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Procedure1 is too long (maximum is 50 characters)")
      end
      it 'procedure2が50文字を超えると登録できない' do
        @recipe.procedure2 = 'あ' * 51
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Procedure2 is too long (maximum is 50 characters)")
      end
      it 'procedure3が50文字を超えると登録できない' do
        @recipe.procedure3 = 'あ' * 51
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("Procedure3 is too long (maximum is 50 characters)")
      end
      it 'userと紐づいてないと登録できない' do
        @recipe.user = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include('User must exist')
      end
    end
  end
end
