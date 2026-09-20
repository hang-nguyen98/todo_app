class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      # category name must not be null
      t.string :name, null: false
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
