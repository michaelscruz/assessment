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

    persist_what_needs_persisting
  end

  def update
    @category_score = CategoryScore.find(params[:id])

    persist_what_needs_persisting
  end

  private

    def category_score_params
      params.require(:category_score).permit(:category_id)
    end

    def persist_what_needs_persisting
      if @category_score.score.nil?
        @category_score.score = params[:answer_value]
      else
        @category_score.score += params[:answer_value].to_i
      end

      @exam = Exam.find(params[:exam_id])
      @score = Score.find_by(user: current_user, exam: @exam)
      if @category_score.save
        @score.questions_answered += 1
        @score.save!
        redirect_to begin_exam_url(@exam)
      else
        @question = @exam.questions.order(:created_at)[@score.questions_answered]
        @question.errors.add("You must choose an answer.")
        redirect_to exam_question_url(@exam, @question)
      end
    end
end
