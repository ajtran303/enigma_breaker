require './lib/rotator'

class Decrypter

  attr_reader :ciphers, :terminal_tokens

  def initialize
    @ciphers = []
    @terminal_tokens = nil
  end

  def add_cipher(rotations)
    @ciphers << Rotator.get_sequence(-rotations)
  end

  def group_tokens(tokens)
    grouped_tokens = []
    tokens.each_slice(4) {|token| grouped_tokens << token}
    @terminal_tokens = grouped_tokens.pop if grouped_tokens.last.size < 4
    grouped_tokens
  end

  def translate(token, cipher)
    if token.is_a? Integer
      cipher[token]
    else
      token
    end
  end

end
