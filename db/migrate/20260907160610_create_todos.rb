class CreateTodos < ActiveRecord::Migration[7.2]
  def change
    create_table :todos do |t|
      # title must not be null
      t.string :title, null: false
      # priority and completed must not be null, default to false
      t.boolean :priority, default: false, null: false
      t.boolean :completed, default: false, null: false
      
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true


      t.timestamps
    end
  end
end
