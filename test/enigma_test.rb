require "./test/test_helper"
require "mocha/minitest"
require "./lib/enigma"

class EnigmaTest < MiniTest::Test

	def test_it_exists_with_attributes
		enigma = Enigma.new
		assert_instance_of Enigma, enigma

		date_of_today = Date.today.strftime('%d%m%y')
		assert_equal date_of_today = enigma.date
	end

	def test_it_can_encrypt_a_message_given_a_key_and_date
		enigma = Enigma.new
		expected = { encryption: "keder ohulw", key: "02715", date: "040895" }
		assert_equal expected, enigma.encrypt("hello world", "02715", "040895")
	end

	def test_it_can_encrypt_a_message_given_a_key
		enigma = Enigma.new
		enigma.stubs(:date).returns("040895")

		expected = { encryption: "keder ohulw", key: "02715", date: "060720" }
		assert_equal expected, enigma.encrypt("hello world", "02715")
	end

	def test_it_has_a_real_date
		enigma = Enigma.new
		date_of_today = enigma.date
		assert_instance_of String, date_of_today
		assert_equal 6, date_of_today.length
		assert_includes 1..31, date_of_today[0..1].to_i
		assert_includes 1..12, date_of_today[2..3].to_i
		assert_includes 0..99, date_of_today[4..5].to_i
	end

	def test_it_can_decrypt_a_message #with key and date
		skip
		enigma = Enigma.new
		expected = { decryption: "hello world", key: "02715", date: "040895" }
		assert_equal expected, enigma.decrypt("keder ohulw", "02715", "040895")
	end

	def test_it_can_validate_input
		skip
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
