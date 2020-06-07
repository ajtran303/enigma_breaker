require './lib/rotator'

class Encrypter
  attr_reader :ciphers

  def initialize
    @ciphers = []
  end

  def group_tokens(tokens)
    grouped_tokens = []
    tokens.each_slice(4) {|token_group| grouped_tokens << token_group}
    grouped_tokens
  end

  def add_cipher(rotations)
    @ciphers << Rotator.get_sequence(rotations)
  end

  def encrypt(sequence_of_tokens)
    cipher_1, cipher_2, cipher_3, cipher_4 = @ciphers
    token_1, token_2, token_3, token_4 = sequence_of_tokens.pop if sequence_of_tokens.last.size < 4
    last_token_sequence = [ translate(token_1, cipher_1), translate(token_2, cipher_2), translate(token_3, cipher_3), translate(token_4, cipher_4) ]
    encryption = sequence_of_tokens.map do |(first, second, third, fourth)|
      [ translate(first, cipher_1), translate(second, cipher_2), translate(third, cipher_3), translate(fourth, cipher_4) ]
    end
    encryption << last_token_sequence
    encryption.join
  end

  def translate(token, cipher)
    if token.is_a? Integer
      cipher[token]
    else
      token
    end
  end

end
