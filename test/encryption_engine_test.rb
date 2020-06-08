require "./test/test_helper"
require "./lib/encryption_engine"
require "./lib/sequenceable"

class EncryptionEngineTest < MiniTest::Test
  include Sequenceable

  def test_it_exists_with_attributes
    encrypter = EncryptionEngine.new
    assert_instance_of EncryptionEngine, encrypter
    assert_equal [], encrypter.ciphers
    assert_nil encrypter.terminal_tokens
  end

  def test_it_can_encrypt
    tokens = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, "!"]
    encrypter_1 = EncryptionEngine.new
    4.times { encrypter_1.add_cipher(0) }
    secret_message = encrypter_1.group_tokens(tokens)
    assert_equal "hello world!", encrypter_1.encrypt(secret_message)

    encrypter_2 = EncryptionEngine.new
    4.times { encrypter_2.add_cipher(1) }
    secret_message = encrypter_2.group_tokens(tokens)
    assert_equal "ifmmpaxpsme!", encrypter_2.encrypt(secret_message)

    encrypter_3 = EncryptionEngine.new
    2.times { encrypter_3.add_cipher(0); encrypter_3.add_cipher(1) }
    secret_message = encrypter_3.group_tokens(tokens)
    assert_equal "hflmoawprmd!", encrypter_3.encrypt(secret_message)
  end

  def test_its_class_can_return_a_cipher
    tokens = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3, "!"]
    shifts = { A:0, B:0, C:0, D:0 }
    assert_equal "hello world!", EncryptionEngine.get_encryption(tokens, shifts)
  end

  def test_it_can_make_terminal_tokens
    tokens = [12, 24, 18, 15, 0, 2, 4, 26]
    assert_equal 8, tokens.size

    encrypter_1 = EncryptionEngine.new
    encrypter_1.group_tokens(tokens)
    assert_nil encrypter_1.terminal_tokens


    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3]
    assert_equal 11, tokens.size

    encrypter_2 = EncryptionEngine.new
    encrypter_2.group_tokens(tokens)
    assert_equal [7, 0, 3], encrypter_2.terminal_tokens


    tokens = [7, 0, 3]
    assert_equal 3, tokens.size

    encrypter_3 = EncryptionEngine.new
    encrypter_3.group_tokens(tokens)
    assert_equal [7, 0, 3], encrypter_3.terminal_tokens
  end

  def test_it_can_add_a_cipher
    encrypter = EncryptionEngine.new
    encrypter.add_cipher(0)

    expected_sequence = get_a_to_space_sequence
    assert_includes encrypter.ciphers, expected_sequence
  end

  def test_it_can_add_many_ciphers
    encrypter = EncryptionEngine.new
    encrypter.add_cipher(0)
    encrypter.add_cipher(0)
    encrypter.add_cipher(0)
    encrypter.add_cipher(0)

    assert_equal 4, encrypter.ciphers.count

    expected_sequence = get_a_to_space_sequence

    assert_equal true, encrypter.ciphers.all? { |cipher| cipher.count == expected_sequence.count }
    assert_equal 4, encrypter.ciphers.count { |cipher| cipher == expected_sequence }
  end

  def test_it_can_group_tokens
    encrypter = EncryptionEngine.new

    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    expected = [[12, 24, 18, 15], [0, 2, 4, 26], [7, 0, 3, 26], ["1", 12, 8, 11], [11, 8, 14, 13], [26, 20, 18, 4], [17, 18, 26, "@"], [26, 19, 7, 4], [26, 1, 4, 6], ["/", "2", "0", "0"], ["4", ".", 26, 22]]

    assert_equal expected, encrypter.group_tokens(tokens)
    assert_equal [14, 22, "!"], encrypter.terminal_tokens
  end

  def test_it_will_encrypt_nothing_if_all_ciphers_added_are_zero_or_twenty_seven
    tokens = [12, 24, 18, 15, 0, 2, 4, 26, 7, 0, 3, 26, "1", 12, 8, 11, 11, 8, 14, 13, 26, 20, 18, 4, 17, 18, 26, "@", 26, 19, 7, 4, 26, 1, 4, 6, "/", "2", "0", "0", "4", ".", 26, 22, 14, 22, "!"]
    expected = "myspace had 1million users @ the beg/2004. wow!"

    encrypter_1 = EncryptionEngine.new
    4.times { encrypter_1.add_cipher(0) }
    grouped_tokens = encrypter_1.group_tokens(tokens)
    assert_equal expected, encrypter_1.encrypt(grouped_tokens)

    encrypter_2 = EncryptionEngine.new
    4.times { encrypter_2.add_cipher(27) }
    grouped_tokens = encrypter_2.group_tokens(tokens)
    assert_equal expected, encrypter_2.encrypt(grouped_tokens)

    encrypter_3 = EncryptionEngine.new
    2.times { encrypter_3.add_cipher(0) }
    2.times { encrypter_3.add_cipher(27) }
    grouped_tokens = encrypter_3.group_tokens(tokens)
    assert_equal expected, encrypter_3.encrypt(grouped_tokens)

    tokens = [12, 24, 18, 15, 0, 2, 4, 26]
    expected = "myspace "
    encrypter_4 = EncryptionEngine.new
    2.times { encrypter_4.add_cipher(0) }
    2.times { encrypter_4.add_cipher(27) }
    grouped_tokens = encrypter_4.group_tokens(tokens)
    assert_equal expected, encrypter_4.encrypt(grouped_tokens)
  end

  def test_it_can_translate
    encrypter_1 = EncryptionEngine.new
    2.times { encrypter_1.add_cipher(0); encrypter_1.add_cipher(1) }
    first_cipher, second_cipher, third_cipher, fourth_cipher = encrypter_1.ciphers

    assert_equal "a", encrypter_1.translate(0, first_cipher)
    assert_equal "c", encrypter_1.translate(1, second_cipher)
    assert_equal "a", encrypter_1.translate(0, third_cipher)
    assert_equal "c", encrypter_1.translate(1, fourth_cipher)

    encrypter_2 = EncryptionEngine.new
    2.times { encrypter_2.add_cipher(0); encrypter_2.add_cipher(1) }
    first_cipher, second_cipher, third_cipher, fourth_cipher = encrypter_2.ciphers

    assert_equal ",", encrypter_2.translate(",", first_cipher)
    assert_equal "\t", encrypter_2.translate("\t", second_cipher)
    assert_equal "!", encrypter_2.translate("!", third_cipher)
    assert_equal "@", encrypter_2.translate("@", fourth_cipher)
  end

end
