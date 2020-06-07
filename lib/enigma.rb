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
    exit unless valid?(secret_message)
  end

  def valid?(inputs)
    message, key, date = inputs
    inputs.all? { |input| input.is_a? String } &&
    (key+date).split("").all? { |input| ("0".."9").include? input } &&
    key.size == 5 && date.size == 6
  end

end
