require "./test/test_helper"
require "./lib/tokenizer"

class TokenizerTest < MiniTest::Test

	def setup
		@tokenizer = Tokenizer.new
	end

	def test_it_exists_with_attributes
		assert_instance_of Tokenizer, @tokenizer
	end

end
