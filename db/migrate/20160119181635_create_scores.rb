class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :score, null: false, default: 0
      t.references :exam, index: true
      t.references :user, index: true
      t.integer :questions_answered, null: false, default: 0

      t.timestamps
    end
  end
end
