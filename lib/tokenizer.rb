require "./lib/sequenceable"
require "./lib/sequencer"

class Tokenizer < Sequencer

  def self.get_tokens(message)
    tokenizer = new
    tokenizer.generate_tokens(message)
  end

  def initialize
    super
  end

  def generate_tokens(message)
    tokens = message.downcase.split("")
    tokens.map do |token|
      @character_sequence.include?(token) ? @character_sequence.index(token) : token
    end
  end

end
