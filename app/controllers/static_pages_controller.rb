class StaticPagesController < ApplicationController
  before_action :redirect_if_signed_in, only: :home
  def home
  end

  def about
  end

  def contact
  end

  def help
  end

  private

    def redirect_if_signed_in
      redirect_to current_user if current_user
    end
end
