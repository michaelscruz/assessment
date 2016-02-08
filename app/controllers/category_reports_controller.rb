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
    @category_reports = CategoryReport.all
  end

  # GET /category_reports/1
  # GET /category_reports/1.json
  def show
  end

  # GET /category_reports/new
  def new
    @category_report = CategoryReport.new
    @exam = Exam.includes(:categories).find_by(id: params[:exam_id])
    # Add view to choose which category to create reports for
    # Add method to determine possible range values
    # => Could force it to choose the lowest number in range and allow the user to set the highest for this report
    # => so that gaps are not left.
  end

  # GET /category_reports/1/edit
  def edit
  end

  # POST /category_reports
  # POST /category_reports.json
  def create
    @category_report = CategoryReport.new(category_report_params)

    respond_to do |format|
      if @category_report.save
        format.html { redirect_to @category_report, notice: 'Category report was successfully created.' }
        format.json { render :show, status: :created, location: @category_report }
      else
        format.html { render :new }
        format.json { render json: @category_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_reports/1
  # PATCH/PUT /category_reports/1.json
  def update
    respond_to do |format|
      if @category_report.update(category_report_params)
        format.html { redirect_to @category_report, notice: 'Category report was successfully updated.' }
        format.json { render :show, status: :ok, location: @category_report }
      else
        format.html { render :edit }
        format.json { render json: @category_report.errors, status: :unprocessable_entity }
      end
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_report_params
      params[:category_report]
    end
end
