require "./test/test_helper"
require "mocha/minitest"
require "./lib/gear"

class GearTest < MiniTest::Test

	def setup
		@gear = Gear.new
	end

	def test_it_exists
		assert_instance_of Gear, @gear
	end

  def test_it_can_make_keys_from_a_seed
    expected_keys = { A:2, B:27, C:71, D:15 }
    assert_equal expected_keys, @gear.make_keys("02715")

    expected_keys = { A:47, B:79, C:91, D:11 }
    assert_equal expected_keys, @gear.make_keys("47911")

    expected_keys = { A:00, B:00, C:00, D:00 }
    assert_equal expected_keys, @gear.make_keys("00000")

    expected_keys = { A:99, B:99, C:99, D:99 }
    assert_equal expected_keys, @gear.make_keys("99999")
  end

  def test_it_can_get_date_of_today
    expected_date = Date.today.strftime('%d%m%y') #ddmmyy
    assert_equal expected_date, @gear.get_date_of_today
  end

  def test_it_can_make_offsets
    expected_date = "040895"
    @gear.stubs(:get_date_of_today).returns(expected_date)

    expected_offsets = { A:1, B:0, C:2, D:5 }
    assert_equal expected_offsets, @gear.make_offsets
  end

  def test_it_can_square_date
    expected_date = "040895"
    @gear.stubs(:get_date_of_today).returns(expected_date)

    expected_square = 1672401025
    assert_equal expected_square, @gear.square_date
  end

  def test_it_can_make_shifts
    expected_shifts = { A:3, B:27, C:73, D:20 }
    assert_equal expected_shifts, @gear.make_shifts
  end

end
