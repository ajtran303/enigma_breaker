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

  def crack(secret_message, *date_of_transmission)
    date_input, = date_of_transmission
    exit unless is_valid_message?(secret_message) && is_valid_date?(date_input)

    date_input ||= get_date_of_today

    full_tokens = Tokenizer.get_tokens(secret_message)
    proto_tokens = get_last_four(full_tokens) if full_tokens.count % 4 == 0
    proto_tokens = get_last_five(full_tokens) if full_tokens.count % 4 == 1
    proto_tokens = get_last_six(full_tokens) if full_tokens.count % 4 == 2
    proto_tokens = get_last_seven(full_tokens) if full_tokens.count % 4 == 3

    cracked_message = nil; cracked_key = nil

    brute_keys = get_zero_to_100_000_sequence

    loop do
      brute_attempt = pad_with_zeroes(brute_keys.shift)
      brute_shifts = Gear.get_shifts(brute_attempt, date_input)
      cracked_message = CipherEngine.get_decryption(proto_tokens, brute_shifts)
      cracked_key = brute_attempt
      break if get_last_four(cracked_message) == " end"
    end

    cracked_shifts = Gear.get_shifts(cracked_key, date_input)
    cracked_message = CipherEngine.get_decryption(full_tokens, cracked_shifts)

    { decryption: cracked_message,
      date: date_input,
      key: cracked_key }
  end

end
