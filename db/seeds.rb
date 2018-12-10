# BUILDING CRYPTOCURRENCIES HASH TO FETCH TO BUILD SEEDS AND FETCH TO API LATER
# IF YOU WANNA ADD A CRYPTOCURRENCY JUST ADD TICKER_NAME WITH A COMMA TO THE HASH
# AND TICKER_CODE AS VALUE
crypto_hash = {
  Bitcoin: "BTC",
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
  Siacoin: "SC",
  Augur: "REP" }

# STRING WITH FIAT CURRENCIES TO FEED INTO API. TO ADD ANOTHER ONE
# TYPE LIKE THIS "USD, EUR, JPY"
fiat_currencies = "USD"

puts "---------- Creating Users ----------"

user = User.new(email: "wheelsnocoiner@wheels.com", first_name: "filipe", last_name: "Custodio", password: 123456, country: "Portugal")
user.save
puts "#{user.email} Successfully Created!"
user = User.new(email: "wheelscoiner@wheels.com", first_name: "Nick", last_name: "Petzold", password: 123456, country: "England")
user.save
puts "#{user.email} Successfully Created!"

puts "---------- USERS CREATED ----------"

puts "---------- Creating Cryptocurrencies ----------"

crypto_hash.each do |key, value|
  coin = Cryptocurrency.new(ticker_name: "#{key}", ticker_code: "#{value}/#{fiat_currencies}")
  coin.save!
  puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"
end

puts "---------- CRYPTOCURRENCIES CREATED ----------"
puts "!!!!!!!!!!!!!!! SEEDS CREATED !!!!!!!!!!!!!!!"


# REFACTOR TOMORROW INTO A PARSE FILE FOR RAILS

# 1 - Creating an empty crypto string to feed the tickers name
crypto_string_with_tickers = ""
# 2 - Creating an empty array to feed the cryptocurrencies names
crypto_array_with_names = []

# 3 - Iterate through the crypto_hash
crypto_hash.each do |key, value|
  # 4 - Build a string with all cryptocurrency tickers "BTC,ETH"
  crypto_string_with_tickers << "#{value},"
  # 5 - Build an array with all cryptocurrency names ["Bitcoin", "Ethereum"]
  crypto_array_with_names << key.to_s
end

# 6 - Transform the ex string "BTC,ETH,XRP," into "BTC,ETH,XRP"
crypto_string_with_tickers = crypto_string_with_tickers.chomp(",")

# 7 - Transform the crypto string into a crypto array with tickers ex: ["BTC","ETH","XRP"]
crypto_array_with_tickers = crypto_string_with_tickers.split(",")

# 8 - Building the API GET Request and Parsing the Response
url_api = "https://min-api.cryptocompare.com/data/pricemulti?fsyms=#{crypto_string_with_tickers}&tsyms=#{fiat_currencies}&api_key=#{ENV['CRYPTO_COMPARE_API_KEY']}"
response = RestClient.get(url_api)
response_parsed = JSON.parse(response)

# Empty hash to build an hash of hashes
crypto_seeds_hash = {}

# THIS RETURNS AN HASH LIKE THIS {btc: 3017.24, eth: 3014.24}
crypto_array_with_tickers.each do |crypto|
  crypto_seeds_hash[crypto] = response_parsed[crypto][fiat_currencies]
end

# THIS WILL RETURN AN HASH OF HASHES LIKE THIS
# {"Bitcoin"=>{"BTC"=>3443.67}, "Ethereum"=>{"ETH"=>200.04}}
CRYPTO_SEEDS_HASH_OF_HASHES = Hash[crypto_array_with_names.zip(crypto_seeds_hash.to_a)].transform_values!{|a| Hash[*a]}
puts CRYPTO_SEEDS_HASH_OF_HASHES
