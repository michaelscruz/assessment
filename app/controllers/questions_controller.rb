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

    if params[:category].blank? && !params[:new_category].blank?
      category = Category.new(name: params[:new_category], exam: @exam)
      @question.category = category
      category.save
    elsif !params[:category].blank?
      @question.category = Category.where(name: params[:category], exam: @exam).first
    end

    if @exam.multiple_choice?
      @question.question_type = "multiple_choice"
    elsif @exam.long_answer? 
      @question.question_type = "long_answer"
    end
    
    if @question.blank?
      redirect_to @exam, notice: "Your test has been successfully created!"
    else
      if @question.save
        if params[:commit] == "Finalize test"
          redirect_to exam_url(@exam), notice: "Your test has been successfully created!"
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
      params.require(:question).permit(:text, :question_type, answers_attributes: [ :text, :value, :_destroy ] )
    end
end
