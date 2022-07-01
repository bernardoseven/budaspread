require 'uri'
require 'net/http'
require 'json'

class ApiCall
  
  # m=ApiCall.market_spreads
  def self.market_spreads
  
    url = URI("http://localhost:3000/api/v1/markets_spread") 

    https = Net::HTTP.new(url.host, url.port);
	
		request = Net::HTTP::Get.new(url)

		response = https.request(request)
		read_body = response.read_body
		parse_json = JSON.parse(read_body)

		return parse_json

  end

  # m=ApiCall.market_spread('btc-clp')
  def self.market_spread(given_market_id)
  	
	  url = URI("http://localhost:3000/api/v1/market_spread") 

	  https = Net::HTTP.new(url.host, url.port);
		
	  request = Net::HTTP::Post.new(url)

	  request.body = "[given_market]=#{given_market_id}&[random]=1"

	  response = https.request(request)
	  read_body = response.read_body
	  parse_json = JSON.parse(read_body)

	  return parse_json
  end

  # m=ApiCall.alert_spread("minutes", 0.1, 'btc-clp', 50000.0)
  def self.alert_spread(time_parameter,
					  						quantity,
					  						given_market,
					  						amount)
    url = URI("http://localhost:3000/api/v1/alert_spread") 

    https = Net::HTTP.new(url.host, url.port);
	
    request = Net::HTTP::Post.new(url)

    request.body = "[time_parameter]=#{time_parameter}&[quantity]=#{quantity}&[given_market]=#{given_market}&[amount]=#{amount}"

    response = https.request(request)
    read_body = response.read_body
    parse_json = JSON.parse(read_body)

    return parse_json
  end

end

