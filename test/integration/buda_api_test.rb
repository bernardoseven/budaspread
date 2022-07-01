require 'test_helper'

class BudaApiTest < ActionDispatch::IntegrationTest #ActiveSupport::TestCase

  def setup
    # base methods wich the api interacts with
    @single_market_spread = RawData.api_market_spread
    @single_market_spread_value = @single_market_spread["ticker"]["current_spread"].to_f
    @every_market_spread = RawData.api_market_spreads
    @polling_alert_spread = RawData.api_alert_spread
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

  test "api should return every market spread in one api call" do
    assert_equal @every_market_spread.count, 24 
  end

  test "api should return given_market spread" do 
    assert @single_market_spread["ticker"]["current_spread"] != nil
  end

  test "api should return in a given moment in the future the future spread and the beginning alert spread with time" do 
    assert @polling_alert_spread["ticker"]["alert_spread"][0] != nil
    assert @polling_alert_spread["ticker"]["alert_spread"][1] != nil
    assert @polling_alert_spread["ticker"]["current_spread_variation"][1] != nil
    assert @polling_alert_spread["ticker"]["current_spread_variation"][2] != nil
  end

  test "api polling time should be later than alert spread" do 
    time_of_setting_alert_spread = @polling_alert_spread["ticker"]["alert_spread"][1].to_time
    setted_polling_time = @polling_alert_spread["ticker"]["current_spread_variation"][2].to_time
    difference = setted_polling_time - time_of_setting_alert_spread
    assert_operator difference, :>, 0.0
  end

end

