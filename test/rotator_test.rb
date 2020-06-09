require "./test/test_helper"
require "./lib/rotator"
require "./lib/sequenceable"

class RotatorTest < MiniTest::Test
  include Sequenceable

  def test_it_exists_with_attributes
    rotator = Rotator.new
    assert_instance_of Rotator, rotator
    expected = get_a_to_space_sequence
    assert_equal expected, rotator.character_sequence
  end

  def test_it_can_rotate_sequence_by_a_number
    rotator_1 = Rotator.new
    rotator_1.rotate_sequence_by(1)
    expected = get_b_to_a_sequence
    assert_equal expected, rotator_1.character_sequence

    rotator_2 = Rotator.new
    rotator_2.rotate_sequence_by(0)
    expected = get_a_to_space_sequence
    assert_equal expected, rotator_2.character_sequence

    rotator_3 = Rotator.new
    rotator_3.rotate_sequence_by(27)
    expected = get_a_to_space_sequence
    assert_equal expected, rotator_3.character_sequence

    rotator_4 = Rotator.new
    rotator_4.rotate_sequence_by(28)
    expected = get_b_to_a_sequence
    assert_equal expected, rotator_4.character_sequence
  end

  def test_its_class_can_get_rotations
    expected = get_b_to_a_sequence
    assert_equal expected, Rotator.get_rotations(1)
  end

end
