require './lib/rotator'

class CipherEngine

  attr_reader :ciphers, :terminal_tokens

  def initialize
    @ciphers = []
    @terminal_tokens = nil
  end

  def self.get_encryption(tokens, shifts)
    encrypter = self.new
    shifts.values_at(:A, :B, :C, :D).each { |shift| encrypter.add_cipher(shift) }
    message = encrypter.group_tokens(tokens)
    encrypter.substitute(message)
  end

  def self.get_decryption(tokens, shifts)
    decrypter = self.new
    shifts.values_at(:A, :B, :C, :D).each { |shift| decrypter.add_cipher(-shift) }
    message = decrypter.group_tokens(tokens)
    decrypter.substitute(message)
  end

  def group_tokens(tokens)
    grouped_tokens = []
    tokens.each_slice(4) { |token| grouped_tokens << token }
    @terminal_tokens = grouped_tokens.pop if grouped_tokens.last.size < 4
    grouped_tokens
  end

  def add_cipher(rotations)
    @ciphers << Rotator.get_sequence(rotations)
  end

  def substitute(sequence_of_tokens)
    substitution_end = translate_all(@terminal_tokens) unless @terminal_tokens == nil
    substitution = sequence_of_tokens.flat_map { |tokens| translate_all(tokens) }
    substitution << substitution_end
    substitution.join
  end

  def translate_all(tokens)
    tokens.zip(@ciphers).map { |(token, cipher)| translate(token, cipher) }
  end

  def translate(token, cipher)
    token.is_a?(Integer) ? cipher[token] : token
  end

end
