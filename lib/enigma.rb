require "./lib/gear"
require "./lib/tokenizer"
require "./lib/cipher_engine"
require "./lib/sequenceable"

class Enigma
  include Sequenceable

  def is_valid_message?(message_input)
    message_input.is_a? String
  end

  def is_valid_key?(key_input)
    ( is_valid_message?(key_input) &&
      is_only_numbers?(key_input) &&
      key_input.size == 5
    ) || key_input.nil?
  end

  def is_valid_date?(date_input)
    ( is_valid_message?(date_input) &&
      is_only_numbers?(date_input) &&
      date_input.size == 6
    ) || date_input.nil?
  end

  def is_only_numbers?(character_input)
    character_input.each_char.all? do |character|
      ("0".."9").include? character
    end
  end

  def is_valid_input?(*inputs_to_validate)
    message, key, date = inputs_to_validate
    is_valid_message?(message) &&
    is_valid_key?(key) &&
    is_valid_date?(date)
  end

  def encrypt(secret_message, *settings)
    initial_key, offset_key = settings
    exit unless is_valid_input?(secret_message, initial_key, offset_key)
    tokens = Tokenizer.get_tokens(secret_message)
    shifts = Gear.get_shifts(initial_key ||= make_random_sequence, offset_key ||= get_date_of_today)
    { encryption: CipherEngine.get_encryption(tokens, shifts),
      key: initial_key,
      date: offset_key }
  end

  def decrypt(secret_message, *settings)
    initial_key, offset_key = settings
    exit unless is_valid_input?(secret_message, initial_key, offset_key)
    tokens = Tokenizer.get_tokens(secret_message)
    shifts = Gear.get_shifts(initial_key, offset_key ||= get_date_of_today)
    { decryption: CipherEngine.get_decryption(tokens, shifts),
      key: initial_key,
      date: offset_key }
  end

  def crack(secret_message, offset_key=nil)
    exit unless is_valid_message?(secret_message) && is_valid_date?(offset_key)
    tokens = Tokenizer.get_tokens(secret_message)
    terminal_tokens = get_last_group(tokens)
    crack_results = brute_attack(terminal_tokens, offset_key ||= get_date_of_today )
    cracked_key, cracked_shifts = crack_results
    { decryption: CipherEngine.get_decryption(tokens, cracked_shifts),
      date: offset_key,
      key: cracked_key }
  end

  def brute_attack(token_sample, offset_key)
    brute_keys = get_zero_to_100_000_sequence
    brute_key = nil; brute_shifts = nil; cracked_keyword = nil
    loop do
      brute_key = pad_with_zeroes(brute_keys.shift)
      brute_shifts = Gear.get_shifts(brute_key, offset_key)
      cracked_keyword = CipherEngine.get_decryption(token_sample, brute_shifts)
      break if get_last_four(cracked_keyword) == " end"
    end
    [brute_key, brute_shifts]
  end

end
