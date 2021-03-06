require "./test/test_helper"
require "mocha/minitest"
require "./lib/enigma"
require "./lib/sequenceable"

class EnigmaTest < MiniTest::Test
	include Sequenceable

	def test_it_exists_with_attributes
		enigma = Enigma.new
		assert_instance_of Enigma, enigma
	end

	def test_it_knows_all_the_keys
		enigma = Enigma.new
		assert_equal (0...100_000).to_a, enigma.get_zero_to_100_000_sequence
	end

	def test_it_can_get_the_last_four
		enigma = Enigma.new
		assert_equal [1,2,3,4], enigma.get_last_four([5,4,3,2,1,2,3,4])
	end

	def test_it_can_get_the_last_five
		enigma = Enigma.new
		assert_equal [2,1,2,3,4], enigma.get_last_five([5,4,3,2,1,2,3,4])
	end

	def test_it_can_get_the_last_six
		enigma = Enigma.new
		assert_equal [3,2,1,2,3,4], enigma.get_last_six([5,4,3,2,1,2,3,4])
	end

	def test_it_can_get_the_last_seven
		enigma = Enigma.new
		assert_equal [4,3,2,1,2,3,4], enigma.get_last_seven([5,4,3,2,1,2,3,4])
	end

	def test_it_can_get_date_of_today
		enigma = Enigma.new
		expected = get_date_of_today
		assert_equal expected, enigma.get_date_of_today
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

	def test_it_can_decrypt_a_message_given_a_key # without date
		enigma_1 = Enigma.new
		enigma_1.stubs(:get_date_of_today).returns("040895")
		encrypted = enigma_1.encrypt("hello world", "02715")

		expected = { decryption: "hello world", key: "02715", date: "040895" }
		assert_equal expected, enigma_1.decrypt(encrypted[:encryption], "02715")
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

		assert_equal true, enigma.valid_message?(valid_message)
		assert_equal false, enigma.valid_message?(invalid_message_1)
		assert_equal false, enigma.valid_message?(invalid_message_2)
	end

	def test_it_knows_valid_key
		enigma = Enigma.new
		valid_key_1 = "02715"
		valid_key_2 = nil
		valid_key_3 = make_random_sequence
		invalid_key_1 = "040895"
		invalid_key_2 = "chars"
		invalid_key_3 = 27150
		assert_equal true, enigma.valid_key?(valid_key_1)
		assert_equal true, enigma.valid_key?(valid_key_2)
		assert_equal true, enigma.valid_key?(valid_key_3)
		assert_equal false, enigma.valid_key?(invalid_key_1)
		assert_equal false, enigma.valid_key?(invalid_key_2)
		assert_equal false, enigma.valid_key?(invalid_key_3)
	end

	def test_it_knows_valid_date
		enigma = Enigma.new
		valid_date_1 = "040895"
		valid_date_2 = nil
		valid_date_3 = get_date_of_today
		invalid_date_1 = "0408950"
		invalid_date_2 = "hello!"
		invalid_date_3 = 11947
		assert_equal true, enigma.valid_date?(valid_date_1)
		assert_equal true, enigma.valid_date?(valid_date_2)
		assert_equal true, enigma.valid_date?(valid_date_3)
		assert_equal false, enigma.valid_date?(invalid_date_1)
		assert_equal false, enigma.valid_date?(invalid_date_2)
		assert_equal false, enigma.valid_date?(invalid_date_3)
	end

	def test_it_knows_what_contains_only_numbers
		enigma = Enigma.new
		valid_input = "02715"
		invalid_input = "chars"

		assert_equal true, enigma.only_numbers?(valid_input)
		assert_equal false, enigma.only_numbers?(invalid_input)
	end

	def test_it_knows_what_is_valid_input
		enigma = Enigma.new
		valid_message_1 = "hello world"
		valid_key_1 = "02715"
		valid_date_1 = "040895"
		assert_equal true, enigma.valid_input?(valid_message_1, valid_key_1, valid_date_1)

		valid_message_2 = "hello world"
		valid_key_2 = nil
		valid_date_2 = "040895"
		assert_equal true, enigma.valid_input?(valid_message_2, valid_key_2, valid_date_2)

		valid_message_3 = "hello world"
		valid_key_3 = nil
		valid_date_3 = nil
		assert_equal true, enigma.valid_input?(valid_message_3, valid_key_3, valid_date_3)

		enigma = Enigma.new
		invalid_message_4 = nil
		valid_key_4 = "02715"
		valid_date_4 = "040895"
		assert_equal false, enigma.valid_input?(invalid_message_4, valid_key_4, valid_date_4)

		enigma = Enigma.new
		valid_message_5 = "hello world"
		invalid_key_5 = "hello"
		valid_date_5 = "040895"
		assert_equal false, enigma.valid_input?(valid_message_5, invalid_key_5, valid_date_5)

		enigma = Enigma.new
		valid_message_6 = "hello world"
		valid_key_6 = "02715"
		invalid_date_6 = "hello!"
		assert_equal false, enigma.valid_input?(valid_message_6, valid_key_6, invalid_date_6)
	end

	def test_it_can_encrypt_a_message_with_no_additional_input
		enigma_1 = Enigma.new
		enigma_1.stubs(:get_date_of_today).returns("040895")
		enigma_1.stubs(:make_random_sequence).returns("02715")

		expected = {:encryption=>"keder ohulw", :key=>"02715", :date=>"040895"}
		assert_equal expected, enigma_1.encrypt("hello world")

		enigma_2 = Enigma.new
		enigma_2.stubs(:get_date_of_today).returns("070620")
		enigma_2.stubs(:make_random_sequence).returns("02715")

		expected = {:encryption=>"nib udmcxpu", :key=>"02715", :date=>"070620"}
		assert_equal expected, enigma_2.encrypt("hello world")
	end

	def test_it_can_make_random_sequence
		enigma = Enigma.new
    random_keys = enigma.make_random_sequence
    assert_instance_of String, random_keys
    assert_equal 5, random_keys.length
    assert_includes 0...100_000, random_keys.to_i
		assert_equal true, random_keys.each_char.all? { |key| ("0".."9").include?(key) }
	end

	def test_it_can_crack_an_encryption_with_a_date
		enigma = Enigma.new
		expected = { decryption: "hello world end", date: "291018", key: "08304" }
		assert_equal expected, enigma.crack("vjqtbeaweqihssi", "291018")
	end

	def test_it_can_crack_an_encryption_with_the_date_of_today
		enigma = Enigma.new
		enigma.stubs(:get_date_of_today).returns("080620")
		expected = { decryption: "hello goth world end", date: "080620", key: "17835" }
		assert_equal expected, enigma.crack("bfntiaiwnibdisnlufpl")
	end

	def test_it_can_brute_attack
		enigma = Enigma.new
		expected = ["17835", {:A=>21, :B=>82, :C=>83, :D=>35}]
		assert_equal expected, enigma.brute_attack([20, 5, 15, 11], "080620")
	end

end
