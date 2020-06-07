require "./test/test_helper"
require "./lib/rotator"

class RotatorTest < MiniTest::Test

  def test_it_exists_with_attributes
    rotator = Rotator.new
    assert_instance_of Rotator, rotator
  end

end
