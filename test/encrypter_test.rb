require "./test/test_helper"
require "./lib/encrypter"

class EncrypterTest < MiniTest::Test

  def test_it_exists_with_attributes
    encrypter = Encrypter.new
    assert_instance_of Encrypter, encrypter
    assert_equal [], encrypter.ciphers
  end

  def test_it_can_add_a_cipher
    encrypter = Encrypter.new
    encrypter.add_cipher(0)

    expected_sequence = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_includes encrypter.ciphers, expected_sequence
  end

  def test_it_can_add_many_ciphers
    encrypter = Encrypter.new
    encrypter.add_cipher(0)
    encrypter.add_cipher(0)
    encrypter.add_cipher(0)
    encrypter.add_cipher(0)

    assert_equal 4, encrypter.ciphers.count

    expected_sequence = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

    assert_equal true, encrypter.ciphers.all? { |cipher| cipher.count == expected_sequence.count }
    assert_equal 4, encrypter.ciphers.count { |cipher| cipher == expected_sequence }
  end

  def test_it_can_group_tokens
    encrypter = Encrypter.new

    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    expected = [[12, 24, 18, 15], [0, 2, 4, 26], [7, 0, 3, 26], ["1", 12, 8, 11], [11, 8, 14, 13], [26, 20, 18, 4], [17, 18, 26, "@"], [26, 19, 7, 4], [26, 1, 4, 6], ["/", "2", "0", "0"], ["4", ".", 26, 22], [14, 22, "!"]]

    assert_equal expected, encrypter.group_tokens(tokens)
  end

  def test_it_will_encrypt_nothing_if_all_ciphers_added_are_zero_or_twenty_seven
    skip
    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    expected = "myspace had 1million users @ the beg/2004. wow!"

    encrypter_1 = Encrypter.new
    4.times { encrypter_1.add_cipher(0) }
    grouped_tokens = encrypter_1.group_tokens(tokens)
    assert_equal expected, encrypter_1.encrypt(grouped_tokens)

    encrypter_2 = Encrypter.new
    4.times { encrypter_2.add_cipher(27) }
    grouped_tokens = encrypter_2.group_tokens(tokens)
    assert_equal expected, encrypter_2.encrypt(grouped_tokens)

    encrypter_3 = Encrypter.new
    2.times { encrypter_3.add_cipher(0) }
    2.times { encrypter_3.add_cipher(27) }
    grouped_tokens = encrypter_3.group_tokens(tokens)
    assert_equal expected, encrypter_3.encrypt(grouped_tokens)
  end

  def test_it_can_translate
    encrypter_1 = Encrypter.new
    2.times { encrypter_1.add_cipher(0); encrypter_1.add_cipher(1) }
    first_cipher, second_cipher, third_cipher, fourth_cipher = encrypter_1.ciphers

    assert_equal "a", encrypter_1.translate(0, first_cipher)
    assert_equal "c", encrypter_1.translate(1, second_cipher)
    assert_equal "a", encrypter_1.translate(0, third_cipher)
    assert_equal "c", encrypter_1.translate(1, fourth_cipher)

    encrypter_2 = Encrypter.new
    2.times { encrypter_2.add_cipher(0); encrypter_2.add_cipher(1) }
    first_cipher, second_cipher, third_cipher, fourth_cipher = encrypter_2.ciphers

    assert_equal ",", encrypter_2.translate(",", first_cipher)
    assert_equal "\t", encrypter_2.translate("\t", second_cipher)
    assert_equal "!", encrypter_2.translate("!", third_cipher)
    assert_equal "@", encrypter_2.translate("@", fourth_cipher)
  end

end
