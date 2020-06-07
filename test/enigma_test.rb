require "./test/test_helper"
require "mocha/minitest"
require "./lib/enigma"

class EnigmaTest < MiniTest::Test

	def test_it_exists_with_attributes
		enigma = Enigma.new
		assert_instance_of Enigma, enigma
	end

	def test_it_can_get_date_of_today
		enigma = Enigma.new
		date_of_today = Date.today.strftime('%d%m%y')
		assert_equal date_of_today, enigma.get_date_of_today
	end

	def test_it_can_encrypt_a_message_given_a_key_and_date
		enigma = Enigma.new
		expected = { encryption: "keder ohulw", key: "02715", date: "040895" }
		assert_equal expected, enigma.encrypt("hello world", "02715", "040895")
	end

	def test_it_can_encrypt_a_message_given_a_key # without date
		enigma = Enigma.new
		enigma.stubs(:get_date_of_today).returns("040895")

		expected = { encryption: "keder ohulw", key: "02715", date: "040895" }
		assert_equal expected, enigma.encrypt("hello world", "02715")
	end

	def test_it_has_a_real_date
		enigma = Enigma.new
		date_of_today = enigma.get_date_of_today
		assert_instance_of String, date_of_today
		assert_equal 6, date_of_today.length
		assert_includes 1..31, date_of_today[0..1].to_i
		assert_includes 1..12, date_of_today[2..3].to_i
		assert_includes 0..99, date_of_today[4..5].to_i
	end

	def test_it_can_decrypt_a_message # with key and date
		enigma = Enigma.new
		expected = { decryption: "hello world", key: "02715", date: "040895" }
		assert_equal expected, enigma.decrypt("keder ohulw", "02715", "040895")
	end

	def test_it_knows_valid_message
		enigma = Enigma.new
		valid_message = "hello world"
		invalid_message_1 = 94080095
		invalid_message_2 = nil

		assert_equal true, enigma.is_valid_message?(valid_message)
		assert_equal false, enigma.is_valid_message?(invalid_message_1)
		assert_equal false, enigma.is_valid_message?(invalid_message_2)
	end

	def test_it_knows_valid_key
		enigma = Enigma.new
		valid_key_1 = "02715"
		valid_key_2 = nil
		invalid_key_1 = "040895"
		invalid_key_2 = "chars"
		invalid_key_3 = 27150
		assert_equal true, enigma.is_valid_key?(valid_key_1)
		assert_equal true, enigma.is_valid_key?(valid_key_2)
		assert_equal false, enigma.is_valid_key?(invalid_key_1)
		assert_equal false, enigma.is_valid_key?(invalid_key_2)
		assert_equal false, enigma.is_valid_key?(invalid_key_3)
	end

	def test_it_knows_valid_date
		enigma = Enigma.new
		valid_date_1 = "040895"
		valid_date_2 = nil
		invalid_date_1 = "0408950"
		invalid_date_2 = "hello!"
		invalid_date_3 = 11947
		assert_equal true, enigma.is_valid_date?(valid_date_1)
		assert_equal true, enigma.is_valid_date?(valid_date_2)
		assert_equal false, enigma.is_valid_date?(invalid_date_1)
		assert_equal false, enigma.is_valid_date?(invalid_date_2)
		assert_equal false, enigma.is_valid_date?(invalid_date_3)
	end

	def test_it_knows_what_contains_only_numbers
		enigma = Enigma.new
		valid_input = "02715"
		invalid_input = "chars"

		assert_equal true, enigma.is_only_numbers?(valid_input)
		assert_equal false, enigma.is_only_numbers?(invalid_input)
	end

end
