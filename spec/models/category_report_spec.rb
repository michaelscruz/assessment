# == Schema Information
#
# Table name: category_reports
#
#  id          :integer          not null, primary key
#  category_id :integer
#  text        :text
#  value_key   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe CategoryReport, type: :model do
  let(:category_report) { FactoryGirl.create :category_report }

  subject { category_report }

  it { should respond_to :category }
  it { should respond_to :text }
  it { should respond_to :value_key }

  it { should be_valid }

  describe "without text" do
    before { category_report.text = " " }

    it { should_not be_valid }
  end

  describe "without category" do
    before { category_report.category = nil }

    it { should_not be_valid }
  end
end
