require "./test/test_helper"
require "./lib/decrypter"

class DecrypterTest < MiniTest::Test

  def test_it_exists_with_attributes
    decrypter = Decrypter.new
    assert_instance_of Decrypter, decrypter
    assert_equal [], decrypter.ciphers
    assert_nil decrypter.terminal_tokens
  end

  def test_it_can_add_a_cipher
    decrypter = Decrypter.new
    decrypter.add_cipher(0)

    expected_sequence = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_includes decrypter.ciphers, expected_sequence
  end

  def test_it_can_add_many_ciphers
    decrypter = Decrypter.new
    decrypter.add_cipher(0)
    decrypter.add_cipher(0)
    decrypter.add_cipher(0)
    decrypter.add_cipher(0)

    assert_equal 4, decrypter.ciphers.count

    expected_sequence = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal true, decrypter.ciphers.all? { |cipher| cipher.count == expected_sequence.count }
    assert_equal 4, decrypter.ciphers.count { |cipher| cipher == expected_sequence }
  end

  def test_it_can_make_terminal_tokens
    tokens = [12, 24, 18, 15, 0, 2, 4, 26]
    assert_equal 8, tokens.size

    decrypter_1 = Decrypter.new
    decrypter_1.group_tokens(tokens)
    assert_nil decrypter_1.terminal_tokens


    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3]
    assert_equal 11, tokens.size

    decrypter_2 = Decrypter.new
    decrypter_2.group_tokens(tokens)
    assert_equal [7, 0, 3], decrypter_2.terminal_tokens

    tokens = [7, 0, 3]
    assert_equal 3, tokens.size

    decrypter_3 = Decrypter.new
    decrypter_3.group_tokens(tokens)
    assert_equal [7, 0, 3], decrypter_3.terminal_tokens
  end


end
