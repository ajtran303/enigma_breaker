class Rotator

  attr_reader :character_sequence

  def initialize
    @character_sequence = ("a".."z").to_a << " "
  end

  def shift_sequence_by(amount)
    sequence = @character_sequence
    amount = amount % sequence.size
    @character_sequence = sequence.rotate(amount)
  end

  def self.get_sequence(shift_amount)
    rotator = Rotator.new
    rotator.shift_sequence_by(shift_amount)
    rotator.character_sequence
  end

end
