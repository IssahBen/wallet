require 'httparty'
require 'json'

response=HTTParty.get('https://api.coincap.io/v2/assets/bitcoin')


parsed_data=JSON.parse(response.body)
puts parsed_data["data"["symbol"]]