class LikesController < ApplicationController
  before_action :set_recipe

  def create
    @like = Like.new(user_id: current_user.id, recipe_id: params[:recipe_id])
    @like.save
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
    @like.destroy
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
