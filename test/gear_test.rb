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
    assert_includes 1...100_000, random_keys.to_i
  end

  def test_it_can_get_date_of_today
    expected_date = Date.today.strftime('%d%m%y') #ddmmyy
    assert_equal expected_date, @gear.get_date_of_today
  end

  def test_it_can_exist_and_work_without_arguments
    gear = Gear.new

    random_keys = gear.keys
    assert_instance_of String, random_keys
    assert_equal 5, random_keys.length
    assert_includes 1...100_000, random_keys.to_i

    key_a = random_keys[0..1].to_i
    key_b = random_keys[1..2].to_i
    key_c = random_keys[2..3].to_i
    key_d = random_keys[3..4].to_i

    expected_keys = { A: key_a, B: key_b, C: key_c, D: key_d }
    assert_equal expected_keys, gear.make_keys

    date_of_today = gear.date
    assert_instance_of String, date_of_today
    assert_equal 6, date_of_today.length
    assert_includes 1..31, date_of_today[0..1].to_i
    assert_includes 1..12, date_of_today[2..3].to_i
    assert_includes 0..99, date_of_today[4..5].to_i

    expected_offsets = gear.square_date.to_s[-4..-1].split("")
    off_a = expected_offsets[0].to_i
    off_b = expected_offsets[1].to_i
    off_c = expected_offsets[2].to_i
    off_d = expected_offsets[3].to_i

    expected_offsets = { A: off_a, B: off_b, C: off_c, D: off_d }
    assert_equal expected_offsets, gear.make_offsets

    shift_a = key_a + off_a
    shift_b = key_b + off_b
    shift_c = key_c + off_c
    shift_d = key_d + off_d

    expected_shifts = { A: shift_a, B: shift_b, C: shift_c, D: shift_d}
  end

end
