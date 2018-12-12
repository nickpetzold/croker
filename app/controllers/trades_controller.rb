class TradesController < ApplicationController
  def index
    # this is an array of instances
    @cryptocurrencies = Cryptocurrency.all
    # this is an hash of hashes with current prices fetched from the api
    @live_prices = crypto_service.call_current_prices
    # this is an array of hashes with latest news fetched from the api
    @live_news = crypto_service.call_latest_news
  end

  def show
    @cryptocurrency = Cryptocurrency.find(params[:id])
    @live_price = crypto_service.call_current_prices[@cryptocurrency.ticker_name][@cryptocurrency.ticker_code]
    # render the chart here
    # still need to figure it out
  end

  def new
    # can create new trades
    @trade = Trade.new
  end

  def create
    @user = current_user
    @trade = Trade.new(trade_params)
    @trade.save
  end

  def trade_params
    params.require(:trade).permit(:usd_price_cents, :usd_amount_cents, :cryptocurrency_amount, :transaction_type)
  end

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end
end
