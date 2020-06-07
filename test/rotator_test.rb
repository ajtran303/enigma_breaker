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
    rotator_1 = Rotator.new
    rotator_1.shift_sequence_by(1)
    expected = ["b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "a"]
    assert_equal expected, rotator_1.character_sequence

    rotator_2 = Rotator.new
    rotator_2.shift_sequence_by(0)
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_equal expected, rotator_2.character_sequence

    rotator_3 = Rotator.new
    rotator_3.shift_sequence_by(27)
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_equal expected, rotator_3.character_sequence

    rotator_4 = Rotator.new
    rotator_4.shift_sequence_by(28)
    expected = ["b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "a"]
    assert_equal expected, rotator_4.character_sequence
  end

  def test_its_class_can_return_a_shifted_sequence
    expected = [" ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    assert_equal expected, Rotator.get_sequence(1)
  end

end
