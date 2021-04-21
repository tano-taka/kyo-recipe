class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy

  with_options presence: true do
    validates :image
    validates :title, length: { maximum: 20 }
    validates :price
    validates :procedure1
    validates_inclusion_of :price, in: 1..1000, message: 'Out of setting range'
  end

  with_options length: { maximum: 50 } do
    validates :procedure1
    validates :procedure2
    validates :procedure3
  end

  def self.search(search)
    if search != ''
      Recipe.where('title LIKE(?)', "%#{search}%").order('created_at DESC')
    else
      Recipe.includes(:user).order('created_at DESC')
    end
  end

  def self.ave(recipe)
    price = 0
    recipe.each do |recipe|
      price += recipe.price
    end
    price / recipe.length
  end
end
