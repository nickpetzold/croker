# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "---------- Creating Users ----------"

user = User.new(email: "wheelsnocoiner@wheels.com", first_name: "filipe", last_name: "Custodio", password: 123456, country: "Portugal")
user.save
puts "#{user.email} Successfully Created!"
user = User.new(email: "wheelscoiner@wheels.com", first_name: "Nick", last_name: "Petzold", password: 123456, country: "England")
user.save
puts "#{user.email} Successfully Created!"

puts "---------- USERS CREATED ----------"

puts "---------- Creating Cryptocurrencies ----------"

coin = Cryptocurrency.new(ticker_name: "Bitcoin", ticker_code: "BTC/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Bitcoin Cash", ticker_code: "BCH/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"


coin = Cryptocurrency.new(ticker_name: "Ethereum", ticker_code: "ETH/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Ethereum Classic", ticker_code: "ETC/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Ripple", ticker_code: "XRP/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Basic Attention Token", ticker_code: "BAT/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "ICON", ticker_code: "ICX/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "VeChain", ticker_code: "VET/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Stellar Lumens", ticker_code: "XLM/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Ravencoin", ticker_code: "RVN/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Tron", ticker_code: "TRX/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Nano", ticker_code: "Nano/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Monero", ticker_code: "XMR/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Binance Coin", ticker_code: "BNB/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Dogecoin", ticker_code: "DOGE/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "QTUM", ticker_code: "QTUM/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Lisk", ticker_code: "LSK/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Waves", ticker_code: "WAVES/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "Sia Coin", ticker_code: "SC/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

coin = Cryptocurrency.new(ticker_name: "REP", ticker_code: "REP/USD")
coin.save
puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"

puts "---------- CRYPTOCURRENCIES CREATED ----------"
puts "!!!!!!!!!!!!!!! SEEDS CREATED !!!!!!!!!!!!!!!"
