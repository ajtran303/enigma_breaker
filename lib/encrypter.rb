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

end
