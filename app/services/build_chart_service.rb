class BuildChartService
  def initialize
  end

  def daily_chart(ticker_code, timeframe)
    minute_prices = crypto_service.call_historical_prices(ticker_code, timeframe)
    minute_time = get_time_data('minute').last(minute_prices.length)
    simplify_data(minute_time, minute_prices)
  end

  def weekly_chart(ticker_code, timeframe)
    hour_prices = crypto_service.call_historical_prices(ticker_code, timeframe)
    hour_time = get_time_data('hour').last(hour_prices.length)
    simplify_data(hour_time.last(168), hour_prices.last(168))
  end

  def monthly_chart(ticker_code, timeframe)
    # set cryptocurrecy
    hour_prices = crypto_service.call_historical_prices(ticker_code, timeframe)
    hour_time = get_time_data('hour').last(hour_prices.length)
    simplify_data(hour_time, hour_prices)
  end

  def yearly_chart(ticker_code, timeframe)
    # dont forget to set @cryptocurrency = Cryptocurrency.find(params[:crypto_id])
    day_prices = crypto_service.call_historical_prices(ticker_code, timeframe)
    day_time = get_time_data('year').last(day_prices.length)
    simplify_data(day_time, day_prices)
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

  def crypto_service
    # API MEMOIZATION CODE
    @crypto_service ||= CryptoCompareService.new
  end
end
