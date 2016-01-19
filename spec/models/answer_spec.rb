# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string(255)
#  value       :integer
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { FactoryGirl.create :answer }

  subject { answer }

  it { should respond_to :text }
  it { should respond_to :value }
  it { should respond_to :question }

  it { should be_valid }

  describe "with no text" do
    before { answer.text = " " }

    it { should_not be_valid }
  end

  describe "with no value" do
    before { answer.value = nil }

    it { should_not be_valid }
  end

  describe "with no associated question" do
    before { answer.question = nil }

    it { should_not be_valid }
  end
end
