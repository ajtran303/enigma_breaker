require "./lib/sequenceable"

class Tokenizer

  include Sequenceable

  attr_reader :character_sequence

  def self.get_tokens(message)
    tokenizer = new
    tokenizer.generate_tokens(message)
  end

  def initialize
    @character_sequence = get_a_to_space_sequence
  end

  def generate_tokens(message)
    tokens = message.downcase.split("")
    tokens.map do |token|
      @character_sequence.include?(token) ? @character_sequence.index(token) : token
    end
  end

end
