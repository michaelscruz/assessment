# == Schema Information
#
# Table name: exams
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  account_id  :integer
#  exam_type   :string(255)
#

class ExamsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :begin, :update, :destroy]

  # GET /tests
  # GET /tests.json
  def index
    @exams = Exam.all
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
    @exam = Exam.includes(:questions, :answers).where(id: params[:id]).first
  end

  # GET /tests/new
  def new
    @exam = Exam.new
  end

  # GET /tests/1/edit
  def edit
    @exam = Exam.find(params[:id])
  end

  # GET /tests/1/begin
  def begin
    @exam = Exam.includes(:questions).find_by(id: params[:id])
    score = Score.find_by(user: current_user, exam: @exam)
    score ||= Score.create(user: current_user, exam: @exam)
    questions = @exam.questions.order(:created_at)
    redirect_to exam_question_url(@exam, questions[score.questions_answered])
  end

  # POST /tests
  # POST /tests.json
  def create
    @exam = Exam.new(exam_params)
    @exam.account = current_user.account

    respond_to do |format|
      if @exam.save
        format.html { redirect_to new_exam_question_path(@exam), notice: 'Exam was successfully created.' }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    @exam = Exam.find(params[:id])
    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url, notice: 'Exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:name, :description, :exam_type)
    end
end
