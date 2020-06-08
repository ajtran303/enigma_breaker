require "./lib/sequenceable"

class Rotator
  include Sequenceable

  attr_reader :character_sequence

  def initialize
    @character_sequence = get_a_to_space_sequence
  end

  def shift_sequence_by(amount)
    amount = amount % @character_sequence.size
    @character_sequence = @character_sequence.rotate(amount)
  end

  def self.get_sequence(shift_amount)
    rotator = self.new
    rotator.shift_sequence_by(shift_amount)
    rotator.character_sequence
  end

end
