class DashboardsController < ApplicationController
  before_action :top_five_traded, :latest_news, :top5_winners, :top5_losers

  def dashboard

  end

  private

  def top_five_traded
    # this returns an hash with the top5 most traded by volume
    # across all the different exchanges
    # Also, it comes sorted from the API
    # ex: {:Bitcoin=>"BTC", :Ethereum=>"ETH", :EOS=>"EOS", :XRP=>"XRP", :ZCash=>"ZEC"}
    @top_five = crypto_service.call_top5_traded
  end

  def latest_news
    @latest_news = crypto_service.call_latest_news
  end

  def top5_winners
    @top5_winners = crypto_service.call_top5_winners
  end

  def top5_losers
    @top5_losers = crypto_service.call_top5_losers
  end

  def crypto_service
    @crypto_service ||= CryptoCompareService.new
  end
end
