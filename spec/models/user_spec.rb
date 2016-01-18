require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create :user }

  subject { user }

  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }

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
  
end
