require 'test_helper'

class BudaApiTest < ActiveSupport::TestCase

  def setup
    @markets = BudaApi.markets
    @single_market_spread = BudaApi.single_spread_calculator('btc-clp')
    @single_market_spread_value = @single_market_spread["ticker"]["current_spread"].to_f
    @every_market_spread = BudaApi.every_market_spread
  end
  
  test "markets should be valid" do
    assert @markets != nil
  end

  test "market response should have 24 markets" do
    assert_equal @markets["markets"].count, 24
  end

  test "single_market_spread object should be valid" do 
    assert @single_market_spread != nil
  end

  test "current spread should be present" do 
    assert @single_market_spread_value != nil
  end

  test "current_spread should be >= 0.0" do 
    # assert_operator 3.0, :<=, 4.0
    # assert_in_delta Math::PI, (22.0/7.0), 0.01 #@single_market_spread_value, :>=, 0.0
    assert_operator @single_market_spread_value, :>=, 0.0
  end

  test "should return every market current spread" do 
    assert_equal @every_market_spread.count, 24
  end

  test "should return current spread of ramdom picked market" do 
    assert_operator @every_market_spread.sample["ticker"]["current_spread"].to_f, :>=, 0.0
  end

end