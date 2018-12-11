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
puts "!!!!!!!!!!!!!!! SEEDS CREATED !!!!!!!!!!!!!!!"
