# == Schema Information
#
# Table name: category_scores
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  category_id :integer
#  score       :integer          default(0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class CategoryScoresController < ApplicationController

  def create
    @category_score = CategoryScore.new(category_score_params)
    @category_score.user = current_user
    @category_score.score = params[:answer_value]

    if @category_score.save
      @exam = @category_score.category.exam
      @score = Score.find_by(user: current_user, exam: @exam)
      @score.questions_answered += 1
      @score.save!
      redirect_to begin_exam_path(@exam)
    else
      @question = @exam.questions.order(:created_at)[@score.questions_answered]
      @question.errors.add(:exam, " something went wrong")
      redirect_to :back
    end
  end

  def update
  end

  private

    def category_score_params
      params.require(:category_score).permit(:category_id)
    end
end
