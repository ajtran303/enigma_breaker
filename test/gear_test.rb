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

  def test_it_can_get_the_date
    expected_date = Date.today.strftime('%d%m%y') #ddmmyy
    assert_equal expected_date, @gear.get_date_of_today
  end

  def test_it_can_make_an_offset
    expected_date = "040895"
    @gear.stubs(:get_date_of_today).returns(expected_date)

    expected_offset = { A:1, B:0, C:2, D:5 }
    assert_equal expected_offset, @gear.make_offset
  end

  def test_it_can_square_the_date
    expected_date = "040895"
    @gear.stubs(:get_date_of_today).returns(expected_date)

    expected_square = 1672401025
    assert_equal expected_square, @gear.square_date
  end

end
