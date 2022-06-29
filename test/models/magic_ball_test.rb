require "test_helper"

class MagicBallTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @magic_ball = MagicBall.new(name:"Magic!")
  end
  
  test "should be valid" do 
    assert @magic_ball.valid?
  end

  test "name should be present" do 
    @magic_ball.name = " "
    assert_not @magic_ball.valid?
  end

end
