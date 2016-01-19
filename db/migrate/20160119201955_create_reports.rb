class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :text
      t.references :user, index: true
      t.references :exam, index: true

      t.timestamps
    end
  end
end
