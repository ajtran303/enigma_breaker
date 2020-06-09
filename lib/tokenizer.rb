require "./lib/sequenceable"

class Tokenizer

  include Sequenceable

  attr_reader :characters

  def self.get_tokens(message)
    tokenizer = new
    tokenizer.generate_tokens(message)
  end

  def initialize
    @characters = get_a_to_space_sequence
  end

  def generate_tokens(message)
    tokens = message.downcase.split("")
    tokens.map do |token|
      @characters.include?(token) ? @characters.index(token) : token
    end
  end

end
