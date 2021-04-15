class Like < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  def self.count(user)
    like = Like.includes(:user, :recipe)
    like_count = 0
    like.each do |like|
      if like.recipe.user_id == user.id
        like_count += 1
      end
    end
    return like_count
  end
end
