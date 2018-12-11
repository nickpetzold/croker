class CryptoCompareService
  # BUILDING CRYPTOCURRENCIES HASH TO FETCH TO BUILD SEEDS AND FETCH TO API LATER
  # IF YOU WANNA ADD A CRYPTOCURRENCY JUST ADD TICKER_NAME WITH A COMMA TO THE HASH
  # AND TICKER_CODE AS VALUE
  CRYPTO_HASH = {
    Bitcoin: "BTC",
    Cardano: "ADA",
    Dignity: "DIG",
    Litecoin: "LTC",
    Bitcoincash: "BCH",
    Ethereum: "ETH",
    Ethereumclassic: "ETC",
    Ripple: "XRP",
    Basicattentiontoken: "BAT",
    Icon: "ICX",
    Vechain: "VET",
    Stellar: "XLM",
    Ravencoin: "RVN",
    Tron: "TRX",
    Nano: "NANO",
    Monero: "XMR",
    Binance: "BNB",
    Dogecoin: "DOGE",
    Qtum: "QTUM",
    Lisk: "LSK",
    Waves: "WAVES",
    Zcash: "ZEC",
    Siacoin: "SC",
    Augur: "REP" }

  FIAT_CURRENCIES = "USD"

  def initialize
    # initializing with empty string that will be filled with tickers
    @crypto_string_with_tickers = ""
    # initializing with empty array that will be filled with names
    @crypto_array_with_names = []
    # base url for get requests with multi currencies and current prices
    @base_url_current_prices = "https://min-api.cryptocompare.com/data/pricemulti"
    # base url for get requests for historical data
    @base_url_historical_prices = "https://min-api.cryptocompare.com/data/histoday"
    # base url for get requests for latest news
    @base_url_current_news = "https://min-api.cryptocompare.com/data/v2/news/?lang=EN"
    @api_key = ENV['CRYPTO_COMPARE_API_KEY']
  end

  def hash_to_string_and_array
    # Iterate through the crypto_hash
    CRYPTO_HASH.each do |key, value|
      # Build a string with all cryptocurrency tickers "BTC,ETH"
      @crypto_string_with_tickers << "#{value},"
      # Build an array with all cryptocurrency names ["Bitcoin", "Ethereum"]
      @crypto_array_with_names << key.to_s
    end
  end

  def call_current_prices
    # call the previous method
    hash_to_string_and_array

    query_params = {
      fsyms: @crypto_string_with_tickers,
      tsyms: FIAT_CURRENCIES,
      api_key: @api_key
    }
    # Transform the ex string "BTC,ETH,XRP," into "BTC,ETH,XRP"
    @crypto_string_with_tickers = @crypto_string_with_tickers.chomp(",")
    # Transform the crypto string into a crypto array with tickers ex: ["BTC","ETH","XRP"]
    crypto_array_with_tickers = @crypto_string_with_tickers.split(",")
    # Building the API GET Request and Parsing the Response
    response = RestClient.get(@base_url_current_prices, {params: query_params})
    response_parsed = JSON.parse(response)
    # Empty hash to build an hash of hashes
    crypto_seeds_hash = {}
    # THIS RETURNS AN HASH LIKE THIS {btc: 3017.24, eth: 3014.24}
    crypto_array_with_tickers.each do |crypto|
      crypto_seeds_hash[crypto] = response_parsed[crypto][FIAT_CURRENCIES]
    end
    # THIS WILL RETURN AN HASH OF HASHES LIKE THIS
    # {"Bitcoin"=>{"BTC"=>3443.67}, "Ethereum"=>{"ETH"=>200.04}}
    Hash[@crypto_array_with_names.zip(crypto_seeds_hash.to_a)].transform_values!{|a| Hash[*a]}
  end

  def call_historical_prices(crypto, days)
    query_params = {
      fsym: crypto,
      tsym: FIAT_CURRENCIES,
      limit: days,
      toTs: Time.new.to_i,
      api_key: @api_key
    }
    response = RestClient.get(@base_url_historical_prices, {params: query_params})
    response_parsed = JSON.parse(response)
    historical_data = response_parsed["Data"]
    historical_data_days_array = []

    historical_data.each do |data|
      historical_data_days_array << data["close"]
    end
    historical_data_days_array
  end

  def call_latest_news
    query_params = {api_key: @api_key}
    response = RestClient.get(@base_url_current_news, {params: query_params})
    JSON.parse(response)["Data"]
  end
end
