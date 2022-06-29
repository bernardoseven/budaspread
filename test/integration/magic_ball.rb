# magic_ball.rb
require 'test_helper'

class MagicBallTest < ActiveSupport::TestCase

  def setup
  	@magic_ball = MagicBall.new(name:"Magic!")
  end
  
  test "should be valid" do 
    assert @magic_ball.valid?
  end

end