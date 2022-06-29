class Api::V1::BudaApiV1Controller < ActionController::API

  def markets_spread
    request = BudaApi.every_market_spread
    
    render json: request, status: 200
  end

  def market_spread
  	request = BudaApi.single_spread_calculator(params["buda_api"]["given_market"])
  
  	render json: request, status: 200
  end

  def alert_spread
  	request = BudaApi.polling(params["buda_api"]["time_parameter"],
							  params["buda_api"]["quantity"].to_f,
							  params["buda_api"]["given_market"],
							  params["buda_api"]["amount"].to_f)

  	render json: request, status: 200
  end

end