# == Schema Information
#
# Table name: category_scores
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  category_id :integer
#  score       :integer          default(0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe CategoryScore, type: :model do
  let(:category_score) { FactoryGirl.create :category_score }

  subject { category_score }

  it { should respond_to :user }
  it { should respond_to :category }
  it { should respond_to :score }
  it "should have an initial score value of 0" do 
    expect(category_score.score).to eq 0
  end
  it { should be_valid }

  describe "with no user" do 
    before { category_score.user = nil }

    it { should_not be_valid }
  end

  describe "with no category" do 
    before { category_score.category = nil }

    it { should_not be_valid }
  end
end
