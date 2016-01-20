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
#  type        :string(255)
#

require 'rails_helper'

RSpec.describe Exam, type: :model do
  let(:exam) { FactoryGirl.create :exam }

  subject { exam }

  it { should respond_to "name" }
  it { should respond_to "description" }
  it { should respond_to :scores }
  it { should respond_to :users }
  it { should respond_to :reports }
  it { should respond_to :account }
  it { should respond_to :type }

  it { should be_valid }

  describe "when name is not present" do
    before { exam.name = " " }

    it { should_not be_valid }
  end

  describe "when name is too short" do
    before { exam.name = "bob" }

    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { exam.name = "a"*51 }

    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { exam.description = " " }

    it { should_not be_valid }
  end

  describe "when it has a score" do
    before do
      score = FactoryGirl.create :score
      exam.scores << score
      score.save!
      @users_count = User.all.count
    end

    it "should have one score" do
      expect(exam.scores.count).to be 1
    end

    it "should have one user" do
      expect(exam.users.count).to be 1
    end

    describe "when the score is destroyed" do
      before { exam.scores.first.destroy }

      it "should not have any users" do
        expect(exam.users.count).to be 0
      end

      it "should not destroy the actual user" do
        expect(User.all.count).to eq @users_count 
      end
    end

    describe "when the exam is destroyed" do
      before { exam.destroy }

      it "should not find a score in the database" do
        expect(Score.all.count).to be 0
      end

      it "should not destroy the user" do
        expect(User.all.count).to eq @users_count 
      end
    end
  end

  describe "when it has a report" do
    before do
      report = FactoryGirl.create :report
      exam.reports << report
      report.save!
    end

    it "should have one report" do
      expect(exam.reports.count).to be 1
    end

    describe "when the exam is destroyed" do
      before { exam.destroy }

      it "should not leave the report in the database" do
        expect(Report.all.count).to be 0
      end
    end
  end

  describe "when account is missing" do
    before { exam.account = nil }

    it { should_not be_valid }
  end
end
