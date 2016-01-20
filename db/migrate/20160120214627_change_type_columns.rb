class ChangeTypeColumns < ActiveRecord::Migration
  def up
    rename_column :questions, :type, :question_type
    rename_column :exams, :type, :exam_type
  end

  def down
    rename_column :questions, :question_type, :type
    rename_column :exams, :exam_type, :type
  end
end
