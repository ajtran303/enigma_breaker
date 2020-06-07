require "./lib/gear"
require "./lib/tokenizer"
require "./lib/encrypter"
require "./lib/decrypter"

class Enigma

  def get_date_of_today
    Date.today.strftime('%d%m%y')
  end

  def encrypt(secret_message, *settings)
    initial_key, offset_key = settings
    offset_key ||= get_date_of_today
    tokens = Tokenizer.get_tokens(secret_message)
    shifts = Gear.get_shifts(initial_key, offset_key)
    encrypted_message = Encrypter.get_encryption(tokens, shifts)
    { encryption: encrypted_message, key: initial_key, date: offset_key }
  end

  def decrypt(secret_message, *settings)
    initial_key, offset_key = settings
    offset_key ||= get_date_of_today
    tokens = Tokenizer.get_tokens(secret_message)
    shifts = Gear.get_shifts(initial_key, offset_key)
    decrypted_message = Decrypter.get_decryption(tokens, shifts)
    { decryption: decrypted_message, key: initial_key, date: offset_key }
  end

  def validate(secret_message)
    puts "That's not right!" unless valid?(secret_message)
    exit unless valid?(secret_message)
  end

  def valid?(inputs)
    is_not_string = inputs.detect { |input| input.class != String }
    return false unless is_not_string.nil?
    is_right_key = (inputs[1].each_char.all? { |character| ("0".."9").include? character }) && (inputs[1].size == 5)
    is_right_date = (inputs[2].each_char.all? { |character| ("0".."9").include? character } || inputs[2].nil?) && (inputs[2].size == 6 || inputs[2].nil?)
    is_not_string.nil? && is_right_key && is_right_date
  end

end
