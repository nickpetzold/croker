class DashboardsController < ApplicationController
  before_action :top_five_traded, :latest_news, :top5_winners, :top5_losers
  before_action :set_portfolio, only: [:dashboard, :portfolio_overview]

  def dashboard
    @portfolio_overview = portfolio_overview
  end

  def portfolio_change_pct

  end

  def portfolio_change_value

  end

  def portfolio_change_resume

  end

  def portfolio_overview
     # {"Bitcoin"=>{"BTC"=>3443.67}, "Ethereum"=>{"ETH"=>200.04}}
    live_prices = crypto_service.call_current_prices

    portfolio_hash = {}

    @portfolios.each do |portfolio|
      portfolio_hash[portfolio.cryptocurrency.ticker_name] = live_prices[portfolio.cryptocurrency.ticker_name.capitalize][portfolio.cryptocurrency.ticker_code]
    end
    # {"Bitcoin"=>3443.67, "Ethereum"=>200.04}
    portfolio_hash
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

  def set_portfolio
    @portfolios = current_user.portfolios
  end
end
