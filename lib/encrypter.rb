require './lib/rotator'

class Encrypter
  attr_reader :ciphers, :terminal_tokens

  def initialize
    @ciphers = []
    @terminal_tokens = nil
  end

  def group_tokens(tokens)
    grouped_tokens = []
    tokens.each_slice(4) {|token_group| grouped_tokens << token_group}
    @terminal_tokens = grouped_tokens.pop if grouped_tokens.last.size < 4
    grouped_tokens
  end

  def add_cipher(rotations)
    @ciphers << Rotator.get_sequence(rotations)
  end

  def encrypt(sequence_of_tokens)
    encryption_end = @terminal_tokens.zip(@ciphers).map do |(token, cipher)|
      translate(token, cipher)
    end unless @terminal_tokens == nil
    encryption = sequence_of_tokens.flat_map do |tokens|
      tokens.zip(@ciphers).map { |(token, cipher)| translate(token, cipher) }
    end << encryption_end
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
