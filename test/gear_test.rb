require "./test/test_helper"
require "./lib/gear"

class GearTest < MiniTest::Test

	def setup
		@gear = Gear.new
	end

	def test_it_exists
		assert_instance_of Gear, @gear
	end

end
