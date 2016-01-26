# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  subdomain  :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { FactoryGirl.create :account }

  subject { account }

  it { should respond_to :name }
  it { should respond_to :subdomain }
  it { should respond_to :user }
  it { should respond_to :exams }

  it { should be_valid }

  describe "when name is missing" do
    before { account.name = " " }

    it { should_not be_valid }
  end

  describe "when name is taken" do
    before do
      second_account = FactoryGirl.create :account
      account.name = second_account.name
    end

    it { should_not be_valid }
  end

  describe "when subdomain is missing" do
    before { account.subdomain = " " }

    it { should_not be_valid }
  end

  describe "subdomain is taken" do
    before do
      second_account = FactoryGirl.create :account
      account.subdomain = second_account.subdomain
    end

    it { should_not be_valid }
  end

  describe "when subdomain contains spaces" do
    before { account.subdomain = "with spaces " }

    it { should_not be_valid }
  end

  describe "when created subdomain and searched subdomain are different cases" do
    before do
      account.subdomain = "MY_SUBDOMAIN"
      account.save!
    end

    it "should not be case sensitive" do
      expect(Account.find_by(subdomain: "my_subdomain").id).to eq account.id
    end
  end

  describe "when user is missing" do 
    before { account.user = nil }

    it { should_not be_valid }
  end

  describe "when it has an exam" do
    before do
      exam = FactoryGirl.create :exam
      account.exams << exam
      exam.save!
    end

    it "should have one exam" do
      expect(account.exams.count).to be 1
    end

    describe "when account is destroyed" do
      before { account.destroy }

      it "should not leave any exams in the database" do
        expect(Exam.all.count).to be 0
      end
    end
  end
end
