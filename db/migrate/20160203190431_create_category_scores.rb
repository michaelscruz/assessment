class CreateCategoryScores < ActiveRecord::Migration
  def change
    create_table :category_scores do |t|
      t.references :user, index: true
      t.references :category, index: true
      t.integer :score, null: false, default: 0

      t.timestamps
    end
  end
end
