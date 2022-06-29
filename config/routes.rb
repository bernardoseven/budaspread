Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      
      get 'markets_spread', to: 'buda_api_v1#markets_spread', via: :get

      post 'market_spread', to: 'buda_api_v1#market_spread', via: :post

      post 'alert_spread', to: 'buda_api_v1#alert_spread', via: :post
      
    end
  end

end
