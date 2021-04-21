class Like < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def self.count(user)
    like = Like.includes(:user, :recipe)
    like_count = 0
    like.each do |like|
      like_count += 1 if like.recipe.user_id == user.id
    end
    like_count
  end
end
