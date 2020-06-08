require "date"
require "./lib/gear"
require "./lib/tokenizer"
require "./lib/encryption_engine"
require "./lib/decryption_engine"

class Enigma

  def get_date_of_today
    Date.today.strftime('%d%m%y')
  end

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

  def make_random_keys
    rand(0...100_000).to_s.rjust(5, "0")
  end

  def encrypt(secret_message, *settings)
    initial_key, offset_key = settings
    exit unless is_valid_input?(secret_message, initial_key, offset_key)
    initial_key ||= make_random_keys
    offset_key ||= get_date_of_today

    tokens = Tokenizer.get_tokens(secret_message)
    shifts = Gear.get_shifts(initial_key, offset_key)

    { encryption: EncryptionEngine.get_encryption(tokens, shifts),
      key: initial_key,
      date: offset_key }
  end

  def decrypt(secret_message, *settings)
    initial_key, offset_key = settings
    exit unless is_valid_input?(secret_message, initial_key, offset_key)
    offset_key ||= get_date_of_today

    tokens = Tokenizer.get_tokens(secret_message)
    shifts = Gear.get_shifts(initial_key, offset_key)

    { decryption: DecryptionEngine.get_decryption(tokens, shifts),
      key: initial_key,
      date: offset_key }
  end

end
