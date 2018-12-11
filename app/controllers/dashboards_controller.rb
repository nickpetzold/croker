class DashboardsController < ApplicationController
  before_action :top_five, :latest_news

  def dashboard

  end

  def top_five
    # this returns an hash with the top5 most traded by volume
    # across all the different exchanges
    # Also, it comes sorted from the API
    # ex: {:Bitcoin=>"BTC", :Ethereum=>"ETH", :EOS=>"EOS", :XRP=>"XRP", :ZCash=>"ZEC"}
    @top_five = CryptoCompareService.new.call_top5_traded
  end

  def latest_news
    @latest_news = CryptoCompareService.new.call_latest_news
  end
end
