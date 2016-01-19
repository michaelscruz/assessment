# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  text       :text
#  user_id    :integer
#  exam_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:report) { FactoryGirl.create :report }

  subject { report }

  it { should respond_to :text }
  it { should respond_to :user }
  it { should respond_to :exam }

  it { should be_valid }

  describe "when user is not present" do
    before { report.user = nil }

    it { should_not be_valid }
  end

  describe "when exam is not present" do 
    before { report.exam = nil }

    it { should_not be_valid }
  end
end
