# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  exam_id    :integer
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryGirl.create :category }

  subject { category }

  it { should respond_to :name }
  it { should respond_to :questions }
  it { should respond_to :category_reports }
  it { should respond_to :exam }
  it { should respond_to :category_scores }

  it { should be_valid }

  describe "when name is blank" do
    before { category.name = " " }

    it { should_not be_valid }
  end

  describe "when exam is missing" do
    before { category.exam = nil }

    it { should_not be_valid }
  end

  describe "with a couple category scores" do 
    before do
      FactoryGirl.create(:category_score, category: category)
      FactoryGirl.create(:category_score, category: category)
    end

    it "should have two category reports" do 
      expect(category.category_scores.count).to eq 2
    end

    describe "destroying the user" do 
      before { category.destroy }

      it "should destroy the category reports, too" do
        expect(CategoryScore.all.count).to eq 0
      end
    end
  end
end
