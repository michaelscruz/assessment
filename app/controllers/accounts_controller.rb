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

class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:edit, :update]

  def new
    @account = Account.new
    @creating_test = params[:creating_test] ? true : false
  end

  def edit
  end

  def create
    @account = Account.new(account_params)
    @account.user = current_user

    if @account.save
      flash[:notice] = "Congrats! #{@account.subdomain} is now your subdomain."
      if params[:creating_test]
        redirect_to new_exam_path
      else
        redirect_to @account.user
      end
    else
      render :new
    end
  end

  def update
    if @account.update(account_params)
      redirect_to :back, notice: "Your account has been updated successfully."
    else
      render :edit
    end
  end

  private

    def account_params
      params.require(:account).permit(:name, :subdomain)
    end

    def set_account
      @account = Account.find_by(user_id: current_user.id)
    end
end
