class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @question = Question.new
    @exam = Exam.includes(:questions).where(id: params[:exam_id]).first
  end

  def create
    @question = Question.new(question_params)
    @exam = Exam.find(params[:exam_id])
    @question.exam = @exam

    if @exam.multiple_choice?
      @question.question_type = "multiple_choice"
    elsif @exam.long_answer? 
      @question.question_type = "long_answer"
    end

    if @question.save
      if params[:commit] == "Finalize test"
        redirect_to user_url(current_user), notice: "Your test has been successfully created!"
      else
        redirect_to new_exam_question_path(@exam), notice: "Your question was successfully added!"
      end
    else
      render :new
    end
  end


  private

    def question_params
      params.require(:question).permit(:text, :question_type, answers_attributes: [ :text, :value, :_destroy ] )
    end
end
