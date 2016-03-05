class AccountsController < ApplicationController
  before_action :set_account
  before_action :set_webfinger_header

  def show
    respond_to do |format|
      format.html
      format.atom
    end
  end

  private

  def set_account
    @account = Account.find_by!(username: params[:username], domain: nil)
  end

  def set_webfinger_header
    response.headers['Link'] = "<#{webfinger_account_url}>; rel=\"lrdd\"; type=\"application/xrd+xml\""
  end

  def webfinger_account_url
    webfinger_url(resource: "acct:#{@account.acct}@#{Rails.configuration.x.local_domain}")
  end
end