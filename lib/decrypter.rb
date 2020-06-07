require './lib/rotator'

class Decrypter

  attr_reader :ciphers, :terminal_tokens

  def initialize
    @ciphers = []
    @terminal_tokens = nil
  end

  def self.get_decryption(tokens, shifts)
    decrypter = Decrypter.new
    shifts.values_at(:A, :B, :C, :D).each { |shift| decrypter.add_cipher(shift) }
    message = decrypter.group_tokens(tokens)
    decrypter.decrypt(message)
  end

  def add_cipher(rotations)
    @ciphers << Rotator.get_sequence(-rotations)
  end

  def decrypt(sequence_of_tokens)
    decryption_end = @terminal_tokens.zip(@ciphers).map do |(token, cipher)|
      translate(token, cipher)
    end unless @terminal_tokens == nil
    decryption = sequence_of_tokens.flat_map do |tokens|
      tokens.zip(@ciphers).map { |(token, cipher)| translate(token, cipher) }
    end << decryption_end
    decryption.join
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
