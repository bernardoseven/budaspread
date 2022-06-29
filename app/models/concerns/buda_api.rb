require 'uri'
require 'net/http'
require 'json'

class BudaApi
 
  # m=BudaApi.markets
  def self.markets
    begin
      retries ||= 0
      url = URI('https://www.buda.com/api/v2/markets')
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)

      response = https.request(request)
      read_body = response.read_body
      parse_json = JSON.parse(read_body)

      return parse_json
    rescue
      retries += 1
      if retries <= 5
        retry
      else
        hash_response = {}
        hash_response["code"] = "not found"
        hash_response["message_code"] = "not found"
        hash_response["message"] = "Resource not loading"
        return hash_response
      end
    end
  end

  # retrieves buda ticker json object with current spread
  # m=BudaApi.single_spread_calculator('btc-clp')
  def self.single_spread_calculator(given_market_id)
    begin
      retries ||= 0
      market_id = given_market_id
      url = URI("https://www.buda.com/api/v2/markets/#{market_id}/ticker")
      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)

      response = https.request(request)
      read_body = response.read_body
      parse_json = JSON.parse(read_body)

      lowest_sell_order = parse_json["ticker"]["min_ask"][0].to_f
      highest_buy_order = parse_json["ticker"]["max_bid"][0].to_f

      current_spread = lowest_sell_order - highest_buy_order

      parse_json["ticker"]["current_spread"] = current_spread.to_s
      #parse_json["ticker"]["alert_spread"] = [current_spread.to_s, Time.now.to_s]

      return parse_json
    rescue => error
      retries += 1
      if retries < 3
        retry
      else
        if parse_json != nil
          return parse_json
        else
          return {message: "#{error}"}
        end
      end
    end
  end

  # m=BudaApi.every_market_spread
  def self.every_market_spread
    begin
      retries ||= 0
      final_list = []
      every_market_json_object = markets["markets"]
      every_market_json_object.each do |single_market|
        final_list << single_spread_calculator(single_market["id"])
      end
      return final_list
    rescue
      retries += 1
      if retries <= 5
        retry
      else
        
      end
    end
  end

  # polling function with given time to run as a parameters
  # parameters seconds, first_parameter_quantity
  # time_parameter can be: minutes, hours, days
  # m=BudaApi.polling("hours", 2, 'btc-clp', 50000.0)
  def self.polling(time_parameter, quantity, given_market_id, alert_spread)
    begin
      retries ||= 0
      case time_parameter
      when "minutes"
        final_time_quantity = quantity * 60
        response = query_in_the_future(final_time_quantity, given_market_id, alert_spread)
        return response
      when "hours"
        final_time_quantity = quantity * 60 * 60
        response = query_in_the_future(final_time_quantity, given_market_id, alert_spread)
        return response
      when "days"
        final_time_quantity = quantity * 60 * 60 * 24
        response = query_in_the_future(final_time_quantity, given_market_id, alert_spread)
        return response
      else
        hash_response = {}
        hash_response["code"] = "not found"
        hash_response["message_code"] = "not found"
        hash_response["message"] = "Invalid parameter"
        
        return hash_response
      end
    rescue
      retries += 1
      if retries <= 5
        retry
      else
        if parse_json != nil
          return parse_json
        else
          return {message: "#{error}"}
        end
      end
    end
  end

  # m=BudaApi.query_in_the_future(10, 'btc-clp', 50000.0)
  def self.query_in_the_future(seconds_to_run, given_market_id, alert_spread)
    begin
      retries ||= 0 
      current_time = Time.now
      alert_spread = ["#{alert_spread.to_s}","#{current_time.to_s}"]
      sleep seconds_to_run
      single_market = single_spread_calculator("#{given_market_id}")
      current_spread_to_f = single_market["ticker"]["current_spread"].to_f
      alert_spread_to_f = alert_spread[0].to_f
      calculation = calculus(current_spread_to_f, alert_spread_to_f)
      single_market["ticker"]["alert_spread"] = alert_spread
      single_market["ticker"]["current_spread_variation"] = calculation
      return single_market
    rescue
      retries += 1
      if retries <= 5
        retry
      else
        return {message: "#{error}"}
      end
    end
  end

  # BudaApi.calculus(1.0,1.0)
  def self.calculus(a,b)
    result = a - b 
    response = {}
    current_time = Time.now.to_s
    if result > 0.0
      return response["current_spread_status"] = ["current_spread is bigger than alert_spread by:", result.to_s, current_time]
    else
      if result < 0.0
        return response["current_spread_status"] = ["current_spread is smaller than alert_spread by:", result.to_s, current_time]
      else
        return response["current_spread_status"] = ["current_spread equals alert_spread", result.to_s, current_time]
      end
    end
  end

end

