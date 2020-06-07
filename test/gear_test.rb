require "./test/test_helper"
require "./lib/gear"

class GearTest < MiniTest::Test

  def setup
    @gear = Gear.new("02715", "040895")
  end

  def test_it_exists_with_attributes
    assert_instance_of Gear, @gear
    assert_equal "02715", @gear.keys
    assert_equal "040895", @gear.date
  end

  def test_it_can_make_keys
    expected_keys = { A:2, B:27, C:71, D:15 }
    assert_equal expected_keys, @gear.make_keys
  end

  def test_it_can_make_offsets
    expected_offsets = { A:1, B:0, C:2, D:5 }
    assert_equal expected_offsets, @gear.make_offsets
  end

  def test_it_can_square_date
    expected_square = 1672401025
    assert_equal expected_square, @gear.square_date
    assert_equal expected_square, @gear.date.to_i**2
  end

  def test_it_can_make_shifts
    expected_shifts = { A:3, B:27, C:73, D:20 }
    assert_equal expected_shifts, @gear.make_shifts
  end

  def test_it_can_make_random_keys
    random_keys = @gear.make_random_keys
    assert_instance_of String, random_keys
    assert_equal 5, random_keys.length
    assert_includes 0...100_000, random_keys.to_i
  end

  def test_its_class_can_output_shifts_key_and_date
    expected_shifts = { A:3, B:27, C:73, D:20 }
    assert_equal expected_shifts, Gear.get_shifts("02715", "040895")
  end

end
