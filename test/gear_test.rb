require "./test/test_helper"
require "./lib/gear"

class GearTest < MiniTest::Test

	def setup
		@gear = Gear.new
	end

	def test_it_exists
		assert_instance_of Gear, @gear
	end

  def test_it_can_make_keys_from_a_seed
    expected_keys = { A:"02", B:"27", C:"71", D:"15" }
    assert_equal expected_keys, @gear.make_keys("02715")
  end

end
