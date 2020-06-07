require "./test/test_helper"
require "./lib/enigma"

class EnigmaTest < MiniTest::Test

	def test_it_exists_with_attributes
		enigma = Enigma.new
		assert_instance_of Enigma, enigma
	end

	def test_it_can_encrypt_a_message
		skip
		enigma = Enigma.new
		#with key and date
		expected = { encryption: "keder ohulw", key: "02715", date: "040895" }
		assert_equal expected, enigma.encrypt("hello world", "02715", "040895")
	end

	def test_it_can_validate_input
		enigma = Enigma.new
		secret_message = ["hello world", "02715", "040895"]
		assert_equal true, enigma.valid?(secret_message)
	end

end
