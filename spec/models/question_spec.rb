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

require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { FactoryGirl.create :question }

  subject { question }

  it { should respond_to :text }
  it { should respond_to :question_type }
  it { should respond_to :long_answer }
  it { should respond_to :exam }
  it { should respond_to :answers }
  it { should respond_to :category }
  it { should respond_to :multiple_choice? }
  it { should respond_to :long_answer? }
  it { should respond_to :has_category? }

  it { should be_valid }

  describe "when not associated with an exam" do 
    before { question.exam = nil }

    it { should_not be_valid }
  end

  describe "when question_type is not properly set" do

    describe "when question_type is blank" do
      before { question.question_type = " " }

      it { should_not be_valid }
    end

    describe "when question_type is not within QUESTION_TYPES" do
      before { question.question_type = "some random question_type" }

      it { should_not be_valid }
    end

  end

  describe "when question_type is multiple_choice" do

    context "and category is blank" do
      before { question.category = nil }
      
      it { should_not be_valid }
    end

    context "and category is not blank" do
      it { should be_valid }
    end
  end

  describe "when question_type is long_answer" do
    before { question.question_type = "long_answer" }

    context "and category is blank" do
      before { question.category = nil }

      it { should be_valid }
    end

    context "and category is not blank" do
      it { should be_valid }
    end
  end
end
