# == Schema Information
#
# Table name: scores
#
#  id                 :integer          not null, primary key
#  score              :integer          default(0), not null
#  exam_id            :integer
#  user_id            :integer
#  questions_answered :integer          default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#

require 'rails_helper'

RSpec.describe Score, type: :model do
  let(:score) { FactoryGirl.create :score }

  subject { score }

  it { should respond_to :score }
  it { should respond_to :questions_answered }
  it { should respond_to :exam }
  it { should respond_to :user }

  it { should be_valid }

  describe "when exam is missing" do
    before { score.exam = nil }

    it { should_not be_valid }
  end

  describe "when user is missing" do
    before { score.user = nil }

    it { should_not be_valid }
  end

  describe "when a new score is initialized" do
    before { @new_score = Score.new }

    it "should have questions_answered value of 0" do 
      expect(@new_score.questions_answered).to be 0
    end
    
    it "should have score value of 0" do
      expect(@new_score.score).to be 0
    end
  end

end
