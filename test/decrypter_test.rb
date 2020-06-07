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


end
