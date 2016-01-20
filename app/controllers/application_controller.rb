class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_account

  def set_account
    redirect_to "http://oakrootassessments.com" if request.domain == "oakroot.net"

    if request.subdomain.in? ["assessment", "www"]
      @account = nil
    else
      @account = Account.find_by_subdomain(request.subdomain)
    end
  end
end
