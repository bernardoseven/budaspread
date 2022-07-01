class Api::V1::BudaApiV1Controller < ActionController::API

  def markets_spread
    request = BudaApi.every_market_spread
    
    render json: request, status: 200
  end

  def market_spread
  	request = BudaApi.single_spread_calculator(params["given_market"])
  
  	render json: request, status: 200
  end

  def alert_spread
  	request = BudaApi.polling(params["time_parameter"],
              							  params["quantity"].to_f,
              							  params["given_market"],
              							  params["amount"].to_f)

  	render json: request, status: 200
  end

end