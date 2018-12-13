class DashboardsController < ApplicationController
  before_action :top_five_traded, :latest_news, :top5_winners, :top5_losers

  def dashboard
    # call here portfolio
    # total trades
    # the icons if its up or down in terms of portfolio

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
    # This returns an array of hashes with news articles
    @latest_news = crypto_service.call_latest_news
  end

  def top5_winners
    # this returns an hash like this
    # {"REP"=>8.108108108108116, "WAVES"=>6.535947712418292, "BNB"=>4.228486646884287, "BAT"=>2.183984116479158, "QTUM"=>1.8749999999999878}
    @top5_winners = crypto_service.call_top5_winners
  end

  def top5_losers
    # this returns an hash like this
    # {"DIG"=>-22.26890756302521, "BCH"=>-4.433786825878439, "ZEC"=>-4.110072323161049, "XLM"=>-3.729401561144838, "LSK"=>-3.361344537815129}
    @top5_losers = crypto_service.call_top5_losers
  end

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end
end
