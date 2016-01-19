require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryGirl.create :category }

  subject { category }

  it { should respond_to :name }
  it { should respond_to :questions }
  it { should respond_to :category_reports }

  it { should be_valid }

  describe "when name is blank" do
    before { category.name = " " }

    it { should_not be_valid }
  end
end
