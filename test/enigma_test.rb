require "./test/test_helper"
require "./lib/enigma"

class EnigmaTest < MiniTest::Test

	def test_it_exists_with_attributes
		@enigma = Enigma.new
		assert_instance_of Enigma, @enigma
	end

end
