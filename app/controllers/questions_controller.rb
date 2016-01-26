class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @question = Question.new
    @exam = Exam.includes(:questions).where(id: params[:exam_id]).first
  end
end
