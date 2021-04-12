class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipe = Recipe.includes(:user).order('created_at DESC')
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


  private

  def recipe_params
    params.require(:recipe).permit(:image, :title, :price, :procedure1, :procedure2, :procedure3, :info).merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

end
