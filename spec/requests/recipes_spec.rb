require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  before do
    @recipe = FactoryBot.create(:recipe)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのレシピのテキストが存在する' do
      get root_path
      expect(response.body).to include(@recipe.title)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのレシピの画像URLが存在する' do
      get root_path
      expect(response.body).to include('test_img.jpg')
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの,レシピの手順①が存在する' do
      get root_path
      expect(response.body).to include(@recipe.procedure1)
    end
    it 'indexアクションにリクエストするとレスポンスにレシピ投稿者が存在する' do
      get root_path
      expect(response.body).to include(@recipe.user.nickname)
    end
    it 'indexアクションにリクエストするとレスポンスにレシピ料金が存在する' do
      get root_path
      expect(response.body).to include(@recipe.price.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿フォームが存在する' do
      get root_path
      expect(response.body).to include('レシピを投稿する')
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      get root_path
      expect(response.body).to include('タイトルから探す')
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get recipe_path(@recipe)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのレシピの画像URLが存在する' do
      get recipe_path(@recipe)
      expect(response.body).to include('test_img.jpg')
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのレシピの手順①が存在する' do
      get recipe_path(@recipe)
      expect(response.body).to include(@recipe.procedure1)
    end
    it 'indexアクションにリクエストするとレスポンスにレシピ投稿者が存在する' do
      get recipe_path(@recipe)
      expect(response.body).to include(@recipe.user.nickname)
    end
    it 'indexアクションにリクエストするとレスポンスにレシピ料金が存在する' do
      get recipe_path(@recipe)
      expect(response.body).to include(@recipe.price.to_s)
    end
    it 'indexアクションにリクエストするとレスポンスにいい値ボタンが存在する' do
      get recipe_path(@recipe)
      expect(response.body).to include('いい値')
    end
    it 'indexアクションにリクエストするとレスポンスに投稿フォームが存在する' do
      get recipe_path(@recipe)
      expect(response.body).to include('レシピを投稿する')
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      get recipe_path(@recipe)
      expect(response.body).to include('タイトルから探す')
    end
  end
end
