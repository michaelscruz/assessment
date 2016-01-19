class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :type
      t.text :long_answer
      t.references :exam, index: true

      t.timestamps
    end
  end
end
