require "./lib/sequenceable"
require "./lib/sequencer"

class Rotator < Sequencer
  include Sequenceable

  def initialize
    super
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
