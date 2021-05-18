class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search, :user]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :identification, only: [:edit, :update, :destroy]

  def index
    @recipe = Recipe.includes(:user, :likes).order('created_at DESC')
    @recipe_pop = Recipe.includes(:liked_users, :likes, :user).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
    @recipe_price = Recipe.includes(:user, :likes).order('price ASC')
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.valid?
      @recipe.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe.id)
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  def search
    @recipe = Recipe.search(params[:keyword])
  end

  def user
    @user = User.find(params[:id])
    @recipe = @user.recipes
    @price = Recipe.ave(@recipe)
    @like_count = Like.count(@user)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:image, :title, :price, :procedure1, :procedure2, :procedure3,
                                   :info).merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def identification
    redirect_to root_path unless current_user.id == @recipe.user_id
  end
end
