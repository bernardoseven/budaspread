require 'uri'
require 'net/http'
require 'json'

class TestBudaApi

  # Testing with real call to the buda api
  # t=TestBudaApi.response_should_have_24_markets_with_13_properties
  def self.response_should_have_24_markets_with_13_properties
	# should return 24 markets with 13 properties
	markets = BudaApi.markets

	count_markets = 0

	if markets["markets"].count == 24
	  
	  markets["markets"].each do |market|
	  	if market.count == 13
	  	  count_markets += 1
	  	end
	  end

	  if count_markets == 24
	  	puts "response_should_have_24_markets_with_13_properties"
	  	return true
	  else
	  	return false
	  end

	end
	
  end  

  # t=TestBudaApi.test_single_spread_calculator
  def self.test_single_spread_calculator
  end
  
  # Testing with sample data
  def self.test_markets_sample
  end

end