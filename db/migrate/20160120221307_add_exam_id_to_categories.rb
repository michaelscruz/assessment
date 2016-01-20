class AddExamIdToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :exam, index: true
  end
end
