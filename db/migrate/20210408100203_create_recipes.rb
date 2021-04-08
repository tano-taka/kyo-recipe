class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title,        null: false
      t.integer :price,      null: false
      t.string :procedure1,  null: false
      t.string :procedure2
      t.string :procedure3
      t.text :info
      t.references :user,   foreign_key: true
      t.timestamps
    end
  end
end
