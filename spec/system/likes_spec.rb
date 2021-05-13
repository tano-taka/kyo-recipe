require 'rails_helper'

RSpec.describe 'いい値機能', type: :system do
  before do
    @recipe = FactoryBot.create(:recipe)
    @user = FactoryBot.create(:user)
  end

  context 'いい値ボタンが押せるとき' do
    it 'ログインしたユーザーはいい値ボタンを押せる' do
      # ログインする
      sign_in(@user)
      # いい値ボタンを押す
      like_done(@recipe)
    end
  end

  context 'いい値ボタンを取り消すとき' do
    it 'ログインしたユーザーは自分の押したいい値ボタンを取り消せる' do
      # ログインする
      sign_in(@user)
      # いい値ボタンを押す
      like_done(@recipe)
      # いい値をしたレシピの詳細へ遷移する
      visit recipe_path(@recipe)
      # いい値ボタンを押す
      click_on 'いい値!(済)'
      # いい値済の表記がなく、いい値ボタンに変更されていることを確認
      expect(page).to have_no_selector '.content-like-done', text: 'いい値!(済)'
      expect(page).to have_selector '.content-like-not', text: 'いい値！'
    end
  end

  context '良いねボタンが押せないとき' do
    it 'ログインしてないといい値ボタンは押せない' do
      # レシピ詳細へ遷移する
      visit recipe_path(@recipe)
      # いい値ボタンをおす
      click_on 'いい値！'
      # サインイン画面へ遷移していることを確認
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
