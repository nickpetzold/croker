class TradesController < ApplicationController
  before_action :set_cryptocurrency, only: [:new, :create]
  def new
    @trade = Trade.new
  end

  def create
    # create a new trade instance with private trade params
    @trade = Trade.new(trade_params)
    # assign this trade to the current user logged in
    @trade.user = current_user
    # assign this trade to the cryptocurrency associated
    @trade.cryptocurrency = @cryptocurrency
    # assign the date
    @trade.date_of_trade = Date.today
    # call the buy or sell private method
    buy_or_sell
  end

  private

  def buy_trade
    # avaluate if user has enough USD balance to buy the cryptocurrency
    if current_user.fiat_balance_cents >= @trade.fiat_amount_cents
      # if user has enough balance, verify if he entered all the required fields in the form
      if @trade.save
        # if the user entered all the required fields in the form
        # update his USD balance by subtracting the trade total amount
        current_user.fiat_balance_cents -= @trade.fiat_amount_cents
        # assign portfolio to user
        user_portfolio = check_portfolio
        # create or update the instance of portfolio with the cryptocurrency bought
        user_portfolio.crypto_amount_held += @trade.cryptocurrency_amount
        user_portfolio.fiat_amount_cents += @trade.fiat_amount_cents
        # save changes to portfolio
        user_portfolio.save
        # save current_user and redirect to dashboard or cryptocurrencies path
        current_user.save
        # redirect to dashboard path after successful buy trade
        redirect_to dashboard_path
      else
        # render new form if user didnt enter all the required fields in the form
        render :new
      end
    else
      # if user doesn't have enough balance redirect to new pop up to recharge !!!!
      redirect_to new_top_up_path, :alert => "NOT ENOUGH USD BALANCE" # becase user doesnt have enough balance
    end
  end

  def sell_trade
    # Verify if user crypto balnce is superior to the amount he wants to sell
    # because user can't sell more than what he has
    if user_crypto_balance?
      # if user has crypto balance that allows him to sell
      # verify if he entered the right params to save the trade
      if @trade.save
        # if trade saved. Subtract the amount of the trade to his current USD balance
        current_user.fiat_balance_cents += @trade.fiat_amount_cents
        # set user portfolio
        user_portfolio = check_portfolio
        # change his portfolio amount to the specific crypto he sold
        user_portfolio.crypto_amount_held -= @trade.cryptocurrency_amount
        # save the changes on his portfolio
        user_portfolio.save
        # save the user changes
        current_user.save
        redirect_to dashboard_path
      else
        # if the params he entered during the form aren't valid
        render :new
      end
    else
      # if he doesn't have enough cryptocurrency balance to make the sell order
      redirect_to cryptocurrencies_path, :alert => "NOT ENOUGH #{@trade.cryptocurrency.ticker_name} BALANCE" # becase user doesnt have enough balance
    end
  end

  def user_crypto_balance?
    # set the amount bought counter
    amount_bought = 0
    # iterate thro all his buy trades for a specific crypto
    current_user.trades.buy.where(cryptocurrency_id: @cryptocurrency).each do |amount|
      # increment the counter with the amount of the cryptocurrency
      amount_bought += amount.cryptocurrency_amount
    end
    # set the amount sold counter
    amount_sold = 0
    # iterate thro all his sell trades for a specific crypto
    current_user.trades.sell.where(cryptocurrency_id: @cryptocurrency).each do |amount|
      # increment the counter with the amount of the cryptocurrency
      amount_sold += amount.cryptocurrency_amount
    end
    # return true or false. If amount bought >= sold then the user has enough balance
    # to create a valid trade.
    amount_bought >= amount_sold
  end

  def buy_or_sell
    # verify if its a trade or a sell
    # if true = buy
    if @trade.buy?
      buy_trade
    else
      # if false = sell
      sell_trade
    end
  end

  def check_portfolio
    # verify if the user has portfolio instances for that specific crypto
    # if he doesn't have a portfolio instance for that crypto, create one
    Portfolio.where(cryptocurrency_id: @cryptocurrency, user_id: current_user).first_or_create
  end

  def trade_params
    params.require(:trade).permit(:fiat_price_cents, :fiat_amount_cents, :cryptocurrency_amount, :transaction_type, :date_of_trade)
  end

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end

  def set_cryptocurrency
    @cryptocurrency = Cryptocurrency.find(params[:cryptocurrency_id])
  end
end
