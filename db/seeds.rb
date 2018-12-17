puts "Cleaning database..."
Trade.destroy_all
Portfolio.destroy_all
TopUp.destroy_all
Cryptocurrency.destroy_all
User.destroy_all

puts "---------- Creating Users ----------"

user = User.new(email: "anandha@gmail.com", first_name: "Anandha", last_name: "Khaou", password: 123456)
user.save
puts "#{user.email} Successfully Created!"
user = User.new(email: "nick@gmail.com", first_name: "Nick", last_name: "Petzold", password: 123456)
user.save
puts "#{user.email} Successfully Created!"

puts "---------- USERS CREATED ----------"

puts "---------- Creating Cryptocurrencies ----------"

CryptoCompareService::CRYPTO_HASH.each do |key, value|
  coin = Cryptocurrency.new(ticker_name: "#{key}", ticker_code: "#{value}")
  coin.save!
  puts "Creating #{coin.ticker_name} with ticker #{coin.ticker_code}"
end

puts "---------- CRYPTOCURRENCIES CREATED ----------"

puts "---------- CREATING TRADES FOR USER ----------"

trade = Trade.new(transaction_type: 0)
trade.user = User.find_by(email: "anandha@gmail.com")
trade.cryptocurrency = Cryptocurrency.find_by(ticker_code: "XRP")
trade.fiat_price_cents = 26.94
trade.fiat_amount_cents = 1000000
trade.cryptocurrency_amount = trade.fiat_amount_cents / trade.fiat_price_cents
trade.date_of_trade = Date.new(2018, 11, 23)
trade.save
portfolio = Portfolio.new(cryptocurrency_id: trade.cryptocurrency.id)
portfolio.crypto_amount_held = trade.cryptocurrency_amount
portfolio.user = User.find_by(email: "anandha@gmail.com")
portfolio.fiat_amount_cents = trade.fiat_amount_cents
portfolio.save

puts "Created new trade and portfolio entry for #{trade.cryptocurrency.ticker_name}"

trade = Trade.new(transaction_type: 0)
trade.user = User.find_by(email: "anandha@gmail.com")
trade.cryptocurrency = Cryptocurrency.find_by(ticker_code: "BTC")
trade.fiat_price_cents = 295023
trade.fiat_amount_cents = 25000000
trade.cryptocurrency_amount = trade.fiat_amount_cents / trade.fiat_price_cents
trade.date_of_trade = Date.new(2018, 12, 01)
trade.save
portfolio = Portfolio.new(cryptocurrency_id: trade.cryptocurrency.id)
portfolio.crypto_amount_held = trade.cryptocurrency_amount
portfolio.user = User.find_by(email: "anandha@gmail.com")
portfolio.fiat_amount_cents = trade.fiat_amount_cents
portfolio.save

puts "Created new trade and portfolio entry for #{trade.cryptocurrency.ticker_name}"


trade = Trade.new(transaction_type: 0)
trade.user = User.find_by(email: "anandha@gmail.com")
trade.cryptocurrency = Cryptocurrency.find_by(ticker_code: "XLM")
trade.fiat_price_cents = 12.34
trade.fiat_amount_cents = 500000
trade.cryptocurrency_amount = trade.fiat_amount_cents / trade.fiat_price_cents
trade.date_of_trade = Date.new(2018, 12, 01)
trade.save
portfolio = Portfolio.new(cryptocurrency_id: trade.cryptocurrency.id)
portfolio.crypto_amount_held = trade.cryptocurrency_amount
portfolio.user = User.find_by(email: "anandha@gmail.com")
portfolio.fiat_amount_cents = trade.fiat_amount_cents
portfolio.save

puts "Created new trade and portfolio entry for #{trade.cryptocurrency.ticker_name}"

trade = Trade.new(transaction_type: 0)
trade.user = User.find_by(email: "anandha@gmail.com")
trade.cryptocurrency = Cryptocurrency.find_by(ticker_code: "EOS")
trade.fiat_price_cents = 232
trade.fiat_amount_cents = 2500000
trade.cryptocurrency_amount = trade.fiat_amount_cents / trade.fiat_price_cents
trade.date_of_trade = Date.new(2018, 12, 13)
trade.save
portfolio = Portfolio.new(cryptocurrency_id: trade.cryptocurrency.id)
portfolio.crypto_amount_held = trade.cryptocurrency_amount
portfolio.user = User.find_by(email: "anandha@gmail.com")
portfolio.fiat_amount_cents = trade.fiat_amount_cents
portfolio.save

puts "Created new trade and portfolio entry for #{trade.cryptocurrency.ticker_name}"

trade = Trade.new(transaction_type: 0)
trade.user = User.find_by(email: "anandha@gmail.com")
trade.cryptocurrency = Cryptocurrency.find_by(ticker_code: "XMR")
trade.fiat_price_cents = 3899
trade.fiat_amount_cents = 10000000
trade.cryptocurrency_amount = trade.fiat_amount_cents / trade.fiat_price_cents
trade.date_of_trade = Date.new(2018, 12, 13)
trade.save
portfolio = Portfolio.new(cryptocurrency_id: trade.cryptocurrency.id)
portfolio.crypto_amount_held = trade.cryptocurrency_amount
portfolio.user = User.find_by(email: "anandha@gmail.com")
portfolio.fiat_amount_cents = trade.fiat_amount_cents
portfolio.save

puts "Created new trade and portfolio entry for #{trade.cryptocurrency.ticker_name}"

trade = Trade.new(transaction_type: 0)
trade.user = User.find_by(email: "anandha@gmail.com")
trade.cryptocurrency = Cryptocurrency.find_by(ticker_code: "ETH")
trade.fiat_price_cents = 8681
trade.fiat_amount_cents = 7500000
trade.cryptocurrency_amount = trade.fiat_amount_cents / trade.fiat_price_cents
trade.date_of_trade = Date.new(2018, 12, 16)
trade.save
portfolio = Portfolio.new(cryptocurrency_id: trade.cryptocurrency.id)
portfolio.crypto_amount_held = trade.cryptocurrency_amount
portfolio.user = User.find_by(email: "anandha@gmail.com")
portfolio.fiat_amount_cents = trade.fiat_amount_cents
portfolio.save

puts "Created new trade and portfolio entry for #{trade.cryptocurrency.ticker_name}"

trade = Trade.new(transaction_type: 0)
trade.user = User.find_by(email: "anandha@gmail.com")
trade.cryptocurrency = Cryptocurrency.find_by(ticker_code: "LTC")
trade.fiat_price_cents = 3299
trade.fiat_amount_cents = 5000000
trade.cryptocurrency_amount = trade.fiat_amount_cents / trade.fiat_price_cents
trade.date_of_trade = Date.new(2018, 12, 16)
trade.save
portfolio = Portfolio.new(cryptocurrency_id: trade.cryptocurrency.id)
portfolio.crypto_amount_held = trade.cryptocurrency_amount
portfolio.user = User.find_by(email: "anandha@gmail.com")
portfolio.fiat_amount_cents = trade.fiat_amount_cents
portfolio.save

puts "Created new trade and portfolio entry for #{trade.cryptocurrency.ticker_name}"

trade = Trade.new(transaction_type: 0)
trade.user = User.find_by(email: "anandha@gmail.com")
trade.cryptocurrency = Cryptocurrency.find_by(ticker_code: "AE")
trade.fiat_price_cents = 34.39
trade.fiat_amount_cents = 1000000
trade.cryptocurrency_amount = trade.fiat_amount_cents / trade.fiat_price_cents
trade.date_of_trade = Date.new(2018, 12, 17)
trade.save
portfolio = Portfolio.new(cryptocurrency_id: trade.cryptocurrency.id)
portfolio.crypto_amount_held = trade.cryptocurrency_amount
portfolio.user = User.find_by(email: "anandha@gmail.com")
portfolio.fiat_amount_cents = trade.fiat_amount_cents
portfolio.save

puts "Created new trade and portfolio entry for #{trade.cryptocurrency.ticker_name}"

trade = Trade.new(transaction_type: 0)
trade.user = User.find_by(email: "anandha@gmail.com")
trade.cryptocurrency = Cryptocurrency.find_by(ticker_code: "AE")
trade.fiat_price_cents = 32.39
trade.fiat_amount_cents = 1000000
trade.cryptocurrency_amount = trade.fiat_amount_cents / trade.fiat_price_cents
trade.date_of_trade = Date.new(2018, 12, 17)
trade.save
portfolio = Portfolio.find_by(cryptocurrency_id: trade.cryptocurrency.id)
portfolio.crypto_amount_held += trade.cryptocurrency_amount
portfolio.fiat_amount_cents += trade.fiat_amount_cents
portfolio.save

puts "Created new trade and portfolio entry for #{trade.cryptocurrency.ticker_name}"


puts "Seeding completed!"
