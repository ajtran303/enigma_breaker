require "./test/test_helper"
require "./lib/encrypter"

class EncrypterTest < MiniTest::Test

  def test_it_exists_with_attributes
    encrypter = Encrypter.new
    assert_instance_of Encrypter, encrypter


    assert_equal 4, encrypter.ciphers.count
    assert_equal true, encrypter.ciphers.all? { |cipher| cipher.count == 27 }

    expected_sequence = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal true, encrypter.ciphers.all? { |cipher| cipher == expected_sequence }

  end

  def test_it_can_group_tokens
    encrypter = Encrypter.new

    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    expected = [[12, 24, 18, 15], [0, 2, 4, 26], [7, 0, 3, 26], ["1", 12, 8, 11], [11, 8, 14, 13], [26, 20, 18, 4], [17, 18, 26, "@"], [26, 19, 7, 4], [26, 1, 4, 6], ["/", "2", "0", "0"], ["4", ".", 26, 22], [14, 22, "!"]]

    assert_equal expected, encrypter.group_tokens(tokens)
  end

  def test_it_can_get_a_cipher_from_tokens
    skip
    encrypter = Encrypter.new
    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]

    grouped_tokens = encrypter.group_tokens(tokens)
    assert_equal "MySpace had 1Million users @ the beg/2004. Wow!", encrypter.cipher(grouped_tokens)
  end


end
