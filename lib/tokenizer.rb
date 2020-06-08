require "./lib/sequenceable"

class Tokenizer
  include Sequenceable

  attr_reader :character_sequence

  def initialize
    @character_sequence = get_a_to_space_sequence
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
    tokenizer = Tokenizer.new
    tokenizer.generate_tokens(message)
  end

end
