class Rotator

  attr_reader :character_sequence

  def initialize
    @character_sequence = ("a".."z").to_a << " "
  end

  def shift_sequence_by(amount)
    sequence = @character_sequence
    amount = amount % sequence.size
    @character_sequence = sequence.rotate(-amount)
  end

end
