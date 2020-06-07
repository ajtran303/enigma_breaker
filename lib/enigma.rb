class Enigma

  def encrypt(*secret_message)
  end

  def valid?(inputs)
    message, key, date = inputs
    inputs.all? { |input| input.is_a? String } &&
    key.size == 5 &&
    date.size == 6
  end

end
