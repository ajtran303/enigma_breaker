require "./test/test_helper"
require "./lib/cipher_engine"
require "./lib/sequenceable"

class CipherEngineTest < MiniTest::Test
  include Sequenceable

  def test_it_exists_with_attributes
    encrypter = CipherEngine.new
    assert_instance_of CipherEngine, encrypter
    assert_equal [], encrypter.ciphers
    assert_nil encrypter.terminal_tokens
  end

  def test_it_can_encrypt
    tokens = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, "!"]
    encrypter_1 = CipherEngine.new
    4.times { encrypter_1.add_cipher(0) }
    secret_message = encrypter_1.parse(tokens)
    assert_equal "hello world!", encrypter_1.compile(secret_message)

    encrypter_2 = CipherEngine.new
    4.times { encrypter_2.add_cipher(1) }
    secret_message = encrypter_2.parse(tokens)
    assert_equal "ifmmpaxpsme!", encrypter_2.compile(secret_message)

    encrypter_3 = CipherEngine.new
    2.times { encrypter_3.add_cipher(0); encrypter_3.add_cipher(1) }
    secret_message = encrypter_3.parse(tokens)
    assert_equal "hflmoawprmd!", encrypter_3.compile(secret_message)
  end

  def test_its_class_can_return_an_encrypted_cipher
    tokens = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, "!"]
    shifts = { A:0, B:0, C:0, D:0 }
    assert_equal "hello world!", CipherEngine.get_encryption(tokens, shifts)

    tokens = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, "!"]
    shifts = { A:1, B:1, C:1, D:1 }
    assert_equal "ifmmpaxpsme!", CipherEngine.get_encryption(tokens, shifts)

  end

  def test_it_can_decrypt_which_means_encrypt_backwards
    tokens = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, "!"]
    decrypter_1 = CipherEngine.new
    4.times { decrypter_1.add_cipher(0) }
    secret_message = decrypter_1.parse(tokens)
    assert_equal "hello world!", decrypter_1.compile(secret_message)

    decrypter_2 = CipherEngine.new
    4.times { decrypter_2.add_cipher(-1) }
    secret_message = decrypter_2.parse(tokens)
    assert_equal "gdkknzvnqkc!", decrypter_2.compile(secret_message)

    decrypter_3 = CipherEngine.new
    2.times { decrypter_3.add_cipher(0); decrypter_3.add_cipher(-1) }
    secret_message = decrypter_3.parse(tokens)
    assert_equal "hdlkozwnrkd!", decrypter_3.compile(secret_message)
  end

  def test_its_class_can_return_a_decrypted_cipher
    tokens = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, "!"]
    shifts_1 = { A:0, B:0, C:0, D:0 }
    assert_equal "hello world!", CipherEngine.get_decryption(tokens, shifts_1)

    shifts_2 = { A:1, B:1, C:1, D:1 }
    assert_equal "gdkknzvnqkc!", CipherEngine.get_decryption(tokens, shifts_2)
  end

  def test_it_can_make_terminal_tokens
    tokens = [12, 24, 18, 15, 0, 2, 4, 26]
    assert_equal 8, tokens.size

    encrypter_1 = CipherEngine.new
    encrypter_1.parse(tokens)
    assert_nil encrypter_1.terminal_tokens

    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3]
    assert_equal 11, tokens.size

    encrypter_2 = CipherEngine.new
    encrypter_2.parse(tokens)
    assert_equal [7, 0, 3], encrypter_2.terminal_tokens


    tokens = [7, 0, 3]
    assert_equal 3, tokens.size

    encrypter_3 = CipherEngine.new
    encrypter_3.parse(tokens)
    assert_equal [7, 0, 3], encrypter_3.terminal_tokens
  end

  def test_it_can_add_a_cipher
    encrypter = CipherEngine.new
    encrypter.add_cipher(0)

    expected_sequence = get_a_to_space_sequence
    assert_includes encrypter.ciphers, expected_sequence
  end

  def test_it_can_add_many_ciphers
    encrypter = CipherEngine.new
    encrypter.add_cipher(0)
    encrypter.add_cipher(0)
    encrypter.add_cipher(0)
    encrypter.add_cipher(0)

    assert_equal 4, encrypter.ciphers.count

    expected_sequence = get_a_to_space_sequence

    assert_equal true, encrypter.ciphers.all? { |cipher| cipher.count == expected_sequence.count }
    assert_equal 4, encrypter.ciphers.count { |cipher| cipher == expected_sequence }
  end

  def test_it_can_parse
    encrypter = CipherEngine.new

    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    expected = [[12, 24, 18, 15], [0, 2, 4, 26], [7, 0, 3, 26], ["1", 12, 8, 11], [11, 8, 14, 13], [26, 20, 18, 4], [17, 18, 26, "@"], [26, 19, 7, 4], [26, 1, 4, 6], ["/", "2", "0", "0"], ["4", ".", 26, 22]]

    assert_equal expected, encrypter.parse(tokens)
    assert_equal [14, 22, "!"], encrypter.terminal_tokens
  end

  def test_it_will_encrypt_nothing_if_all_ciphers_added_are_zero_or_twenty_seven
    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    expected = "myspace had 1million users @ the beg/2004. wow!"

    encrypter_1 = CipherEngine.new
    4.times { encrypter_1.add_cipher(0) }
    grouped_tokens = encrypter_1.parse(tokens)
    assert_equal expected, encrypter_1.compile(grouped_tokens)

    encrypter_2 = CipherEngine.new
    4.times { encrypter_2.add_cipher(27) }
    grouped_tokens = encrypter_2.parse(tokens)
    assert_equal expected, encrypter_2.compile(grouped_tokens)

    encrypter_3 = CipherEngine.new
    2.times { encrypter_3.add_cipher(0) }
    2.times { encrypter_3.add_cipher(27) }
    grouped_tokens = encrypter_3.parse(tokens)
    assert_equal expected, encrypter_3.compile(grouped_tokens)

    tokens = [12, 24, 18, 15, 0, 2, 4, 26]
    expected = "myspace "
    encrypter_4 = CipherEngine.new
    2.times { encrypter_4.add_cipher(0) }
    2.times { encrypter_4.add_cipher(27) }
    grouped_tokens = encrypter_4.parse(tokens)
    assert_equal expected, encrypter_4.compile(grouped_tokens)
  end

  def test_it_can_translate
    encrypter_1 = CipherEngine.new
    2.times { encrypter_1.add_cipher(0); encrypter_1.add_cipher(1) }
    first_cipher, second_cipher, third_cipher, fourth_cipher = encrypter_1.ciphers

    assert_equal "a", encrypter_1.translate(0, first_cipher)
    assert_equal "c", encrypter_1.translate(1, second_cipher)
    assert_equal "a", encrypter_1.translate(0, third_cipher)
    assert_equal "c", encrypter_1.translate(1, fourth_cipher)

    encrypter_2 = CipherEngine.new
    2.times { encrypter_2.add_cipher(0); encrypter_2.add_cipher(1) }
    first_cipher, second_cipher, third_cipher, fourth_cipher = encrypter_2.ciphers

    assert_equal ",", encrypter_2.translate(",", first_cipher)
    assert_equal "\t", encrypter_2.translate("\t", second_cipher)
    assert_equal "!", encrypter_2.translate("!", third_cipher)
    assert_equal "@", encrypter_2.translate("@", fourth_cipher)
  end

end
