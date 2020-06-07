require "./lib/gear"
require "./lib/tokenizer"
require "./lib/encrypter"

class Enigma

  def encrypt(*secret_message)
    validate(secret_message)
    message_input, key_input, date_input = secret_message
    shifts, key, date = Gear.get_shifts(key_input, date_input).values_at(:shifts, :key, :date)
    tokens = Tokenizer.get_tokens(message_input)
    encryption = Encrypter.get_encryption(tokens, shifts)
    { encryption: encryption, key: key, date: date }
  end

  def validate(secret_message)
    puts "That's not right!" unless valid?(secret_message)
    # exit unless valid?(secret_message)
  end

  def valid?(inputs)
    is_not_string = inputs.find { |input| input.class != String }
    return false unless is_not_string.nil?
    is_right_key = (inputs[1].each_char.all? { |character| ("0".."9").include? character }) && (inputs[1].size == 5)
    is_right_date = (inputs[2].each_char.all? { |character| ("0".."9").include? character } || inputs[2].nil?) && (inputs[2].size == 6 || inputs[2].nil?)
    is_not_string.nil? && is_right_key && is_right_date
  end

end
