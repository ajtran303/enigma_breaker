class Tokenizer

  attr_reader :character_sequence

  def initialize
    @character_sequence = ("a".."z").to_a << " "
  end

  def self.get_tokens(message)
    tokenizer = Tokenizer.new
    tokenizer.generate_tokens(message)
  end

  def generate_tokens(message)
    characters = message.downcase.split("")
    characters.map do |character|
      if character_sequence.include?(character)
        character_sequence.index(character)
      else
        character
      end
    end
  end

end
