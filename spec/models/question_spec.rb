require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { FactoryGirl.create :question }

  subject { question }

  it { should respond_to :text }
  it { should respond_to :type }
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

  describe "when type is not properly set" do

    describe "when type is blank" do
      before { question.type = " " }

      it { should_not be_valid }
    end

    describe "when type is not within QUESTION_TYPES" do
      before { question.type = "some random type" }

      it { should_not be_valid }
    end

  end

  describe "when type is multiple_choice" do

    context "and category is blank" do
      before { question.category = nil }
      
      it { should_not be_valid }
    end

    context "and category is not blank" do
      it { should be_valid }
    end
  end

  describe "when type is long_answer" do
    before { question.type = "long_answer" }

    context "and category is blank" do
      before { question.category = nil }

      it { should be_valid }
    end

    context "and category is not blank" do
      it { should be_valid }
    end
  end
end
