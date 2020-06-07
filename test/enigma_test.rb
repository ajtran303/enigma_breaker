require "./test/test_helper"
require "./lib/enigma"

class EnigmaTest < MiniTest::Test

	def setup
		@enigma = Enigma.new
	end

	def test_it_exists
		assert_instance_of Enigma, @enigma
	end

  def test_it_can_pass_a_message_given_a_key_and_date
    # use {encryption: "hello world"} for first tests
    # change later to {encryption: "keder ohulw"}
    expected_encryption = { encryption: "hello world", key: "02715", date: "040895" }
    assert_equal expected_encryption, @enigma.no_crypt("hello world", "02715", "040895")
  end

end
