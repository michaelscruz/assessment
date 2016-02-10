# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  text          :string(255)
#  question_type :string(255)
#  long_answer   :text
#  exam_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  category_id   :integer
#

class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @question = Question.new
    @exam = Exam.includes(:questions).find_by(id: params[:exam_id])
  end

  def show
    @question = Question.includes(:answers, :exam).find_by(id: params[:id])
    @exam = @question.exam
    @score = Score.find_by(user: current_user, exam: @exam)
    if @question.multiple_choice?
      @category_score = CategoryScore.find_by(:category => @question.category, :user => current_user)
      @category_score ||= CategoryScore.new 
    end
  end

  def create
    @question = Question.new(question_params)
    @exam = Exam.find(params[:exam_id])
    @question.exam = @exam
    @question.set_type

    @question.set_category(params[:category], params[:new_category]) if  @question.multiple_choice?

    if @question.blank? && params[:commit] == "Finalize test"
      if @exam.questions.empty?
        @question.errors.add(:exam, "must have at least one question")
        render :new
      else
        redirect_to @exam, notice: "Your test has been successfully created!"
      end
    else
      if @question.save
        if params[:commit] == "Finalize test"
          redirect_to category_reports_exam_path(@exam), notice: "Your test has been successfully created!"
        else
          redirect_to new_exam_question_path(@exam), notice: "Your question was successfully added!"
        end
      else
        render :new
      end
    end
  end

  private

    def question_params
      params.require(:question).permit(:text, :question_type, answers_attributes: [ :text, :value, :question_id, :_destroy ] )
    end
end
