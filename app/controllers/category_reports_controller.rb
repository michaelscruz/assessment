# == Schema Information
#
# Table name: category_reports
#
#  id          :integer          not null, primary key
#  category_id :integer
#  text        :text
#  created_at  :datetime
#  updated_at  :datetime
#  value_min   :integer
#  value_max   :integer
#

class CategoryReportsController < ApplicationController
  before_action :set_category_report, only: [:show, :edit, :update, :destroy]

  # GET /category_reports
  # GET /category_reports.json
  def index
    @category = Category.includes(:category_reports, :exam).find_by(id: params[:category_id])
    @category_reports = @category.category_reports.order("value_min asc")
  end

  # GET /category_reports/1
  # GET /category_reports/1.json
  def show
  end

  # GET /category_reports/new
  def new
    @category_report = CategoryReport.new
    set_exam_and_category
    @value_max = params[:value_max] || @category.find_value_max
    @value_min = params[:value_min] || @category.find_remaining_value_min
  end

  # GET /category_reports/1/edit
  def edit
    @value_max = @category_report.value_max
    @value_min = @category_report.value_min
  end

  # POST /category_reports
  # POST /category_reports.json
  def create
    @category_report = CategoryReport.new(category_report_params)
    set_exam_and_category
    @category_report.category = @category 
    @value_max = @category.find_value_max

    if @category_report.save
      if @category.find_remaining_value_min == @value_max
        # Go back to the list of categories if all reports have been created for this category
        @category.reports_complete = true
        @category.save!
        redirect_to category_reports_exam_path(@exam), notice: "All reports for category #{@category.name} have been created successfully"
      else
        # Go back to another new report form for this category if not all values have been covered
        redirect_to new_exam_category_category_report_path(@exam, @category, value_min: @category_report.value_max + 1, value_max: @value_max), notice: "Category report created successfully"
      end
    else
      @value_min = @category.find_remaining_value_min
      render :new
    end
  end

  # PATCH/PUT /category_reports/1
  # PATCH/PUT /category_reports/1.json
  def update
    if @category_report.update(category_report_params)
      redirect_to exam_category_category_reports_path(@exam, @category), notice: "Your report was successfully updated."
    else
      @value_min = @category_report.value_min
      @value_max = @category_report.value_max
      render :edit
    end
  end

  # DELETE /category_reports/1
  # DELETE /category_reports/1.json
  def destroy
    @category_report.destroy
    respond_to do |format|
      format.html { redirect_to category_reports_url, notice: 'Category report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_report
      @category_report = CategoryReport.find(params[:id])
      set_exam_and_category
    end

    def set_exam_and_category
      @exam = Exam.includes(:categories, :questions, :answers).find_by(id: params[:exam_id])
      @category = @exam.categories.find_by(id: params[:category_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_report_params
      params.require(:category_report).permit(:text, :value_max, :value_min)
    end
end
