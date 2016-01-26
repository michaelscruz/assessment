class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @question = Question.new
    @exam = Exam.includes(:questions).where(id: params[:exam_id]).first
  end

  private

    def question_params
      params.require(:question).permit(:text, :question_type, answers_attributes: { :text, :value, :_destroy } )
end
