class RecipesController < ApplicationController
  
  def index
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save

    redirect_to root_path
  end


  private

  def recipe_params
    params.require(:recipe).permit(:image, :title, :price, :procedure1, :procedure2, :procedure3, :info).merge(user_id: current_user.id)
  end
end
