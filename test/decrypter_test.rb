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
    decrypter_1 = Decrypter.new
    decrypter_1.add_cipher(0)

    expected_sequence = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_includes decrypter_1.ciphers, expected_sequence

    decrypter_2 = Decrypter.new
    decrypter_2.add_cipher(1)

    expected_sequence = [" ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    assert_includes decrypter_2.ciphers, expected_sequence
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

  def test_it_can_group_tokens
    decrypter = Decrypter.new

    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    expected = [[12, 24, 18, 15], [0, 2, 4, 26], [7, 0, 3, 26], ["1", 12, 8, 11], [11, 8, 14, 13], [26, 20, 18, 4], [17, 18, 26, "@"], [26, 19, 7, 4], [26, 1, 4, 6], ["/", "2", "0", "0"], ["4", ".", 26, 22]]

    assert_equal expected, decrypter.group_tokens(tokens)
    assert_equal [14, 22, "!"], decrypter.terminal_tokens
  end

  def test_it_can_translate
    decrypter_1 = Decrypter.new
    2.times { decrypter_1.add_cipher(0); decrypter_1.add_cipher(1) }
    first_cipher, second_cipher, third_cipher, fourth_cipher = decrypter_1.ciphers

    assert_equal "a", decrypter_1.translate(0, first_cipher)
    assert_equal " ", decrypter_1.translate(0, second_cipher)
    assert_equal "a", decrypter_1.translate(0, third_cipher)
    assert_equal " ", decrypter_1.translate(0, fourth_cipher)

    decrypter_2 = Decrypter.new
    2.times { decrypter_2.add_cipher(0); decrypter_2.add_cipher(1) }
    first_cipher, second_cipher, third_cipher, fourth_cipher = decrypter_2.ciphers

    assert_equal ",", decrypter_2.translate(",", first_cipher)
    assert_equal "\t", decrypter_2.translate("\t", second_cipher)
    assert_equal "!", decrypter_2.translate("!", third_cipher)
    assert_equal "@", decrypter_2.translate("@", fourth_cipher)
  end

  def test_it_will_decrypt_nothing_if_all_ciphers_added_are_zero_or_twenty_seven
    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    expected = "myspace had 1million users @ the beg/2004. wow!"

    decrypter_1 = Decrypter.new
    4.times { decrypter_1.add_cipher(0) }
    grouped_tokens = decrypter_1.group_tokens(tokens)
    assert_equal expected, decrypter_1.decrypt(grouped_tokens)

    decrypter_2 = Decrypter.new
    4.times { decrypter_2.add_cipher(27) }
    grouped_tokens = decrypter_2.group_tokens(tokens)
    assert_equal expected, decrypter_2.decrypt(grouped_tokens)

    decrypter_3 = Decrypter.new
    2.times { decrypter_3.add_cipher(0) }
    2.times { decrypter_3.add_cipher(27) }
    grouped_tokens = decrypter_3.group_tokens(tokens)
    assert_equal expected, decrypter_3.decrypt(grouped_tokens)

    tokens = [12, 24, 18, 15, 0, 2, 4, 26]
    expected = "myspace "
    decrypter_4 = Decrypter.new
    2.times { decrypter_4.add_cipher(0) }
    2.times { decrypter_4.add_cipher(27) }
    grouped_tokens = decrypter_4.group_tokens(tokens)
    assert_equal expected, decrypter_4.decrypt(grouped_tokens)
  end

  def test_it_can_decrypt_which_means_encrypt_backwards
    tokens = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, "!"]
    decrypter_1 = Decrypter.new
    4.times { decrypter_1.add_cipher(0) }
    secret_message = decrypter_1.group_tokens(tokens)
    assert_equal "hello world!", decrypter_1.decrypt(secret_message)

    decrypter_2 = Decrypter.new
    4.times { decrypter_2.add_cipher(1) }
    secret_message = decrypter_2.group_tokens(tokens)
    assert_equal "gdkknzvnqkc!", decrypter_2.decrypt(secret_message)

    decrypter_3 = Decrypter.new
    2.times { decrypter_3.add_cipher(0); decrypter_3.add_cipher(1) }
    secret_message = decrypter_3.group_tokens(tokens)
    assert_equal "hdlkozwnrkd!", decrypter_3.decrypt(secret_message)
  end

  def test_its_class_can_return_a_cipher
    tokens = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, "!"]
    shifts = { A:0, B:0, C:0, D:0 }
    assert_equal "hello world!", Decrypter.get_decryption(tokens, shifts)
  end

end
