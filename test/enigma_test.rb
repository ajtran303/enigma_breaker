require "./test/test_helper"
require "./lib/enigma"

class EnigmaTest < MiniTest::Test

	def test_it_exists_with_attributes
		enigma = Enigma.new
		assert_instance_of Enigma, enigma
	end

	def test_it_can_encrypt_a_message #with key and date
		enigma = Enigma.new
		expected = { encryption: "keder ohulw", key: "02715", date: "040895" }
		assert_equal expected, enigma.encrypt("hello world", "02715", "040895")
	end

	def test_it_can_decrypt_a_message #with key and date
		enigma = Enigma.new
		expected = { decryption: "hello world", key: "02715", date: "040895" }
		assert_equal expected, enigma.decrypt("keder ohulw", "02715", "040895")
	end

	def test_it_can_validate_input
		enigma = Enigma.new
		secret_message = ["hello world", "02715", "040895"]
		assert_equal true, enigma.valid?(secret_message)

		bad_message_1 = ["hello world", "02715009", "040895"]
		assert_equal false, enigma.valid?(bad_message_1)

		bad_message_2 = ["hello world", "02715", "094080095"]
		assert_equal false, enigma.valid?(bad_message_2)

		bad_message_3 = ["hello world", "chars", "040895"]
		assert_equal false, enigma.valid?(bad_message_3)

		bad_message_4 = ["hello world", "02715", "hello!"]
		assert_equal false, enigma.valid?(bad_message_4)

		bad_message_5 = [43770, 2715, 40895]
		assert_equal false, enigma.valid?(bad_message_5)
	end

end
