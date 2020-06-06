class Tokenizer

  attr_reader :character_sequence

  def initialize
    @character_sequence = ("a".."z").to_a << " "
  end

end
