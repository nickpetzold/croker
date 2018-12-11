class TradesController < ApplicationController
  def index
    # this is an array of instances
    @cryptocurrencies = Cryptocurrency.all
    # this is an hash of hashes with current prices fetched from the api
    @live_prices = CryptoCompareService.new.call_current_prices
    # this is an array of hashes with latest news fetched from the api
    @live_news = CryptoCompareService.new.call_latest_news
  end

  def show
    @crypto = Cryptocurrency.find(params[:id])
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
    params.require(:trade).permit(:usd_cents_rate, :usd_cents_value, :cryptocurrency_value, :transaction_type)
  end
end
