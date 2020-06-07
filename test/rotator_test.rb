require "./test/test_helper"
require "./lib/rotator"

class RotatorTest < MiniTest::Test

  def test_it_exists_with_attributes
    rotator = Rotator.new
    assert_instance_of Rotator, rotator

    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_equal expected, rotator.character_sequence
  end

  def test_it_can_shift_sequence_by_a_number
    rotator = Rotator.new
    rotator.shift_sequence_by(1)
    expected = [" ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    assert_equal expected, rotator.character_sequence
  end

end
