class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :title, length: { maximum: 20 }
    validates :price
    validates :procedure1
    validates_inclusion_of :price, in: 1..2000, message: 'Out of setting range'
  end

  with_options length: { maximum: 50 } do
    validates :procedure1
    validates :procedure2
    validates :procedure3
  end
end
