require 'rails_helper'

RSpec.describe 'レシピ投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @recipe = FactoryBot.build(:recipe)
  end
  context ' レシピ投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 投稿ページに移動する
      visit new_recipe_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_img.jpg')
      attach_file('recipe_image', image_path)
      fill_in 'recipe_title', with: @recipe.title
      fill_in 'recipe_price', with: @recipe.price
      fill_in 'recipe_procedure1', with: @recipe.procedure1
      fill_in 'recipe_procedure2', with: @recipe.procedure2
      fill_in 'recipe_procedure3', with: @recipe.procedure3
      fill_in 'recipe_info', with: @recipe.info
      # 送信するとRecipeモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Recipe.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容のレシピが存在することを確認する（画像）
      expect(page).to have_selector ".list-image-box"
      # トップページには先ほど投稿した内容のレシピが存在することを確認する（タイトルなど）
      expect(page).to have_content(@recipe_title)
      expect(page).to have_content(@recipe_price)
      expect(page).to have_content(@recipe_procedure1)
      expect(page).to have_content(@recipe_procedure2)
      expect(page).to have_content(@recipe_procedure3)
      expect(page).to have_content(@recipe_info)
    end
  end
  context 'ツイート投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # 新規投稿ページに遷移する
      visit new_recipe_path
      # ログインページに遷移することを確認する。
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
