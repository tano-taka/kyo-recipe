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
      expect(page).to have_selector '.list-image-box'
      # トップページには先ほど投稿した内容のレシピが存在することを確認する（タイトルなど）
      expect(page).to have_content(@recipe.title)
      expect(page).to have_content(@recipe.price)
      expect(page).to have_content(@recipe.procedure1)
    end
  end
  context 'レシピ投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # 新規投稿ページに遷移する
      visit new_recipe_path
      # ログインページに遷移することを確認する。
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe 'レシピの編集', type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end
  context 'レシピ編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したレシピの編集ができる' do
      # レシピ1を投稿したユーザーでログインする
      sign_in(@recipe1.user)
      # レシピ１の詳細画面へ遷移する
      visit recipe_path(@recipe1)
      # レシピ1に「更新」ボタンがあることを確認する
      expect(page).to have_link '更新', href: edit_recipe_path(@recipe1)
      # 更新ページへ遷移する
      visit edit_recipe_path(@recipe1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#recipe_title').value
      ).to eq(@recipe1.title)
      expect(
        find('#recipe_price').value
      ).to eq(@recipe1.price.to_s)
      expect(
        find('#recipe_procedure1').value
      ).to eq(@recipe1.procedure1)
      expect(
        find('#recipe_procedure2').value
      ).to eq(@recipe1.procedure2)
      expect(
        find('#recipe_procedure3').value
      ).to eq(@recipe1.procedure3)
      expect(
        find('#recipe_info').value
      ).to eq(@recipe1.info)
      # 投稿内容を編集する
      fill_in 'recipe_title', with: "#{@recipe1.title}+変更"
      fill_in 'recipe_price', with: @recipe1.price + 1
      fill_in 'recipe_procedure1', with: "#{@recipe1.procedure1}+変更"
      fill_in 'recipe_procedure2', with: "#{@recipe1.procedure2}+変更"
      fill_in 'recipe_procedure3', with: "#{@recipe1.procedure3}+変更"
      fill_in 'recipe_info', with: "#{@recipe1.info}+変更"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Recipe.count }.by(0)
      # 完了後詳細画面に遷移したことを確認する
      expect(current_path).to eq(recipe_path(@recipe1))
      # 変更した内容が反映されていることを確認する
      expect(page).to have_content(@recipe1.price + 1)
      expect(page).to have_content("#{@recipe1.procedure1}+変更")
      expect(page).to have_content("#{@recipe1.procedure2}+変更")
      expect(page).to have_content("#{@recipe1.procedure3}+変更")
      expect(page).to have_content("#{@recipe1.info}+変更")
      # トップページに遷移する
      visit root_path
      # トップページに変更したレシピのタイトルが存在することを確認する
      expect(page).to have_content("#{@recipe1.title}+変更")
    end
  end
  context 'レシピ編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したレシピの編集画面には遷移できない' do
      # レシピ1を投稿したユーザーでログインする
      sign_in(@recipe1.user)
      # レシピ2の詳細画面へ遷移する
      visit recipe_path(@recipe2)
      # レシピ２の詳細に「更新」がないことを確認
      expect(page).to have_no_link '更新', href: edit_recipe_path(@recipe2)
    end
    it 'ログインしていないとレシピの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # レシピ1の詳細に遷移する
      visit recipe_path(@recipe1)
      # レシピ1の詳細に「更新」がないことを確認
      expect(page).to have_no_link '更新', href: edit_recipe_path(@recipe1)
      # レシピ2の詳細に遷移する
      visit recipe_path(@recipe2)
      # レシピ2の詳細に「更新」がないことを確認
      expect(page).to have_no_link '更新', href: edit_recipe_path(@recipe2)
    end
  end
end

RSpec.describe 'レシピ削除', type: :system do
  before do
    @recipe1 = FactoryBot.create(:recipe)
    @recipe2 = FactoryBot.create(:recipe)
  end

  context 'レシピ削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したレシピの削除ができる' do
      # レシピ1を投稿したユーザーでログインする
      sign_in(@recipe1.user)
      # レシピ1の詳細に遷移する
      visit recipe_path(@recipe1)
      # レシピ1の詳細に「削除」があることを確認する
      expect(page).to have_link '削除', href: recipe_path(@recipe1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      click_link '削除', href: recipe_path(@recipe1)
      expect do
        page.accept_confirm '削除したデータは戻りません、よろしいですか？'
        sleep 0.5
      end.to change { Recipe.count }.by(-1)
      # トップページに遷移していることを確認
      expect(current_path).to eq(root_path)
    end
  end
  context 'レシピ削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したレシピの削除ができない' do
      # レシピ1を投稿したユーザーでログインする
      sign_in(@recipe1.user)
      # レシピ2の「詳細」へ遷移する
      visit recipe_path(@recipe2)
      # レシピ2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: recipe_path(@recipe2)
    end
    it 'ログインしていないとレシピの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # レシピ1の詳細に遷移する
      visit recipe_path(@recipe1)
      # レシピ1の詳細に「更新」がないことを確認
      expect(page).to have_no_link '削除', href: recipe_path(@recipe1)
      # レシピ2の詳細に遷移する
      visit recipe_path(@recipe2)
      # レシピ2の詳細に「更新」がないことを確認
      expect(page).to have_no_link '削除', href: recipe_path(@recipe2)
    end
  end
end
