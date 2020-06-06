require "./test/test_helper"
require "./lib/tokenizer"

class TokenizerTest < MiniTest::Test

	def setup
		@tokenizer = Tokenizer.new
	end

	def test_it_exists_with_attributes
		assert_instance_of Tokenizer, @tokenizer
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_equal expected, @tokenizer.character_sequence
	end

end
