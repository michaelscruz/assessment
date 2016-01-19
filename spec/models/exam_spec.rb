# == Schema Information
#
# Table name: exams
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Exam, type: :model do
  let(:exam) { FactoryGirl.create :exam }

  subject { exam }

  it { should respond_to "name" }
  it { should respond_to "description" }

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

end
