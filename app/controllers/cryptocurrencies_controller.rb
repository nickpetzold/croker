class CryptocurrenciesController < ApplicationController
 skip_before_action :authenticate_user!, only: [:index]


 def index
   # this is an array of instances
   @cryptocurrencies = Cryptocurrency.all
   # this is an hash of hashes with current prices fetched from the api
   @live_prices = crypto_service.call_current_prices

   if params['query'].present?
     @cryptocurrencies = Cryptocurrency.search_by_ticker_name_and_ticker_code(params[“query”])
   else
     @cryptocurrencies = Cryptocurrency.all
   end
     # @cryptocurrencies_search =

   # this condition takes care of showing the “show” when a cryptocurrency is selected
   if params[:crypto_id]
     @cryptocurrency = Cryptocurrency.find(params[:crypto_id])
     @data = []
     day_prices = crypto_service.call_historical_prices(@cryptocurrency.ticker_code, 'daily')
     hour_prices = crypto_service.call_historical_prices(@cryptocurrency.ticker_code, 'hourly')
     minute_prices = crypto_service.call_historical_prices(@cryptocurrency.ticker_code, 'minutely')
     @latest_price = minute_prices.last
     # Construct array of corresponding times for price data. #last accommodates for where
     # price data returned is less than asked for.
     day_time = get_time_data('year').last(day_prices.length)
     hour_time = get_time_data('hour').last(hour_prices.length)
     minute_time = get_time_data('minute').last(minute_prices.length)
     # Simplify data so that each graph is made up of the same number of datapoints
     @data << simplify_data(day_time, day_prices) # Yearly data
     @data << simplify_data(hour_time, hour_prices) # Monthly data
     @data << simplify_data(hour_time.last(168), hour_prices.last(168)) # Weekly data
     @data << simplify_data(minute_time, minute_prices) # Daily data
     # @live_price = crypto_service.call_current_prices[@cryptocurrency.ticker_name][@cryptocurrency.ticker_code]

     # --------------TODO LATER------------------
     # CALL THE CHART ON THE SHOW
     # CALL THE USER BALANCE ON THE SHOWD
     # DISPLAY THE TIMEFRAME
   end
 end

 private

 def crypto_service
   # API MEMOIZATION CODE
   @crypto_service ||= CryptoCompareService.new
 end

 def get_time_data(period)
   time = []
   case period
   when 'year'
     last_year = DateTime.now - 365
     365.times { |days| time << (last_year + days).strftime('%s').to_i * 1000 }
   when 'hour'
     last_month = DateTime.now - 30
     760.times { |hours| time << (last_month + ((1 / 24.0) * hours)).strftime('%s').to_i * 1000 }
   when 'minute'
     yesterday = DateTime.now - 1
     1440.times { |minutes| time << (yesterday + ((1 / 1440.0) * minutes)).strftime('%s').to_i * 1000 }
   else
     puts 'That is not a valid time period'
   end
   return time
 end

 def simplify_data(time, price)
   # This method reduces the number of data points used to plot each graph
   # to around 150
   result = []
   n = (time.length / 150)
   if n == 1
     result << time
     result << price
   else
     result << (n - 1).step(time.size - 1, n).map { |i| time[i] }
     result << (n - 1).step(price.size - 1, n).map { |i| price[i] }
   end
   result[0].zip(result[1])
 end
end
