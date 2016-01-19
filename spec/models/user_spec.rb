# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create :user }

  subject { user }

  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :scores }
  it { should respond_to :exams }

  it { should be_valid }

  describe "with an invalid email address" do

    describe "with no email address" do
      before { user.email = " " }

      it { should_not be_valid }
    end

    describe "with no @ symbol" do
      before { user.email = "userexample.com" }

      it { should_not be_valid }
    end

  end

  describe "with no first name" do
    before { user.first_name = " " }

    it { should_not be_valid }
  end

  describe "with no last name" do
    before { user.last_name = " " }

    it { should_not be_valid }
  end
  
  describe "with a score" do
    before do
      score = FactoryGirl.create :score
      user.scores << score
    end

    it "should have one score" do
      expect(user.scores.count).to be 1
    end

    it "should have an exam" do
      expect(user.exams.count).to be 1
    end

    describe "after deleting the score" do
      before { user.scores.first.destroy }

      it "should not have any exams" do
        expect(user.exams.count).to be 0
      end
      
      it "should not destroy the exam itself" do
        expect(Exam.all.count).to be 1
      end
    end

    describe "after deleting the user" do
      before { user.destroy }

      it "should have no scores in the database" do
        expect(Score.all.count).to be 0
      end
      
      it "should not destroy the exam" do
        expect(Exam.all.count).to be 1
      end
    end
  end
end
