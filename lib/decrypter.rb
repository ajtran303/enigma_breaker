require './lib/rotator'

class Decrypter

  attr_reader :ciphers, :terminal_tokens

  def initialize
    @ciphers = []
    @terminal_tokens = nil
  end

  def add_cipher(rotations)
    @ciphers << Rotator.get_sequence(rotations)
  end

end
