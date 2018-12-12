class TradesController < ApplicationController
  def index
  end

  def show
  end

  def new
    # can create new trades
    # fetch information from forms rendered in html
    # raise
    @cryptocurrency = Cryptocurrency.find(params[:id])
    @trade = Trade.new
    raise


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
