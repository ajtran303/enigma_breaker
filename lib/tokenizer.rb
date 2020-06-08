require "./lib/sequenceable"
require "./lib/sequencer"

class Tokenizer < Sequencer
  include Sequenceable

  def initialize
    super
  end

  def generate_tokens(message)
    characters = message.downcase.split("")
    characters.map do |character|
      @character_sequence.include?(character) ?
        @character_sequence.index(character) :
        character
    end
  end

  def self.get_tokens(message)
    tokenizer = self.new
    tokenizer.generate_tokens(message)
  end

end
