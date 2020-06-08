require "./lib/sequenceable"

class Rotator
  include Sequenceable

  attr_reader :character_sequence

  def initialize
    @character_sequence = get_a_to_space_sequence
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
