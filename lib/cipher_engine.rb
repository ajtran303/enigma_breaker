require "./lib/rotator"

class CipherEngine

  attr_reader :ciphers, :terminal_tokens

  def self.get_encryption(tokenized_input, shifts)
    encrypter = new
    shifts.values.each { |shift| encrypter.add_cipher(shift) }
    cipher_input = encrypter.parse(tokenized_input)
    encrypter.compile(cipher_input)
  end

  def self.get_decryption(tokenized_input, shifts)
    decrypter = new
    shifts.values.each { |shift| decrypter.add_cipher(-shift) }
    cipher_input = decrypter.parse(tokenized_input)
    decrypter.compile(cipher_input)
  end

  def initialize
    @ciphers = []
    @terminal_tokens = nil
  end

  def parse(tokens)
    parsed_tokens = tokens.each_slice(4).map { |group_of_tokens| group_of_tokens }
    @terminal_tokens = parsed_tokens.pop if parsed_tokens.last.size < 4
    parsed_tokens
  end

  def add_cipher(shift)
    @ciphers << Rotator.get_rotations(shift)
  end

  def compile(token_groups)
    cipher_text = token_groups.flat_map { |token_group| translate_all(token_group) }
    cipher_text << translate_all(@terminal_tokens) unless @terminal_tokens.nil?
    cipher_text.join
  end

  def translate_all(tokens)
    tokens.zip(@ciphers).map { |(token, cipher)| translate(token, cipher) }
  end

  def translate(token, cipher)
    token.is_a?(Integer) ? cipher[token] : token
  end

end
