puts "Cleaning database..."
TopUp.destroy_all
Cryptocurrency.destroy_all
User.destroy_all

puts "---------- Creating Users ----------"

user = User.new(email: "wheelsnocoiner@wheels.com", first_name: "filipe", last_name: "Custodio", password: 123456, country: "Portugal")
user.save
puts "#{user.email} Successfully Created!"
user = User.new(email: "wheelscoiner@wheels.com", first_name: "Nick", last_name: "Petzold", password: 123456, country: "England")
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

amount_of_trades = 300
1.upto(amount_of_trades) do |i|
puts "--------------------------------------------------------------------------------------------"
random_crypto_id = (1..CryptoCompareService::CRYPTO_HASH.count).to_a.sample
trades_params = {
  transaction_type: ["buy","sell"].sample,
  user_id: 2,
  cryptocurrency_id: random_crypto_id,
  fiat_price_cents: rand(1..100000),
  fiat_amount_cents: rand(1..100000),
  cryptocurrency_amount: rand(1..10000),
  date_of_trade: DateTime.now - 5
}
  trade = Trade.new(trades_params)
  trade.save
  portfolio = Portfolio.where(cryptocurrency_id: trade.cryptocurrency, user_id: trades_params[:user_id]).first_or_create
  portfolio.crypto_amount_held = trade.cryptocurrency_amount
  portfolio.fiat_amount_cents = trade.fiat_amount_cents
  portfolio.save
  puts "  #{i} - #{trade.fiat_amount_cents} USD #{trade.transaction_type} order of #{trade.cryptocurrency_amount} #{trade.cryptocurrency.ticker_name} for #{trade.user.first_name} successfully created!"
end

puts "---------- #{amount_of_trades} TRADES Successfully CREATED!! ----------"
puts "---------- PORTFOLIO UPDATED!! ---------------"
