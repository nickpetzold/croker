class DashboardsController < ApplicationController
  before_action :top_five, :latest_news

  def dashboard

  end

  private

  def top_five
    # this returns an hash with the top5 most traded by volume
    # across all the different exchanges
    # Also, it comes sorted from the API
    # ex: {:Bitcoin=>"BTC", :Ethereum=>"ETH", :EOS=>"EOS", :XRP=>"XRP", :ZCash=>"ZEC"}
    @top_five = crypto_service.call_top5_traded
  end

  def latest_news
    @latest_news = crypto_service.call_latest_news
  end

  def crypto_service
    @crypto_service ||= CryptoCompareService.new
  end
end
