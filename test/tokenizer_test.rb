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

  def test_its_class_can_get_tokens
    message = "MySpace had 1Million users @ the beg/2004. Wow!"
    expected = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    assert_equal expected, Tokenizer.get_tokens(message)
  end

  def test_it_can_generate_tokens
    expected = [0]
    assert_equal expected, @tokenizer.generate_tokens("a")

    expected = [0, 0, 0, 0]
    assert_equal expected, @tokenizer.generate_tokens("aAaA")

    expected = [0, 0, 0, 0]
    assert_equal expected, @tokenizer.generate_tokens("AaaA")

    expected = [0, 0, 0, 0]
    assert_equal expected, @tokenizer.generate_tokens("AAAA")

    expected = [26, 26, 26, 26]
    assert_equal expected, @tokenizer.generate_tokens("    ")

    expected = [7, 4, 11, 11, 14]
    assert_equal expected, @tokenizer.generate_tokens("hello")

    expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
    assert_equal expected, @tokenizer.generate_tokens("hello world")

    expected = [7, 4, 11, 11, 14, ",", 26, 22, 14, 17, 11, 3, "!", "!", "!"]
    assert_equal expected, @tokenizer.generate_tokens("hello, world!!!")

    expected = ["!", "?", "&", "&", "&"]
    assert_equal expected, @tokenizer.generate_tokens("!?&&&")

    expected = ["1", "9", "9", "9", "-", "2", "0", "0", "0"]
    assert_equal expected, @tokenizer.generate_tokens("1999-2000")

    expected = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    assert_equal expected, @tokenizer.generate_tokens("MySpace had 1Million users @ the beg/2004. Wow!")
  end

end
