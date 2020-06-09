require "./lib/sequenceable"
require "./lib/sequencer"

class Rotator < Sequencer

  def self.get_rotations(amount)
    rotator = new
    rotator.rotate_sequence_by(amount)
    rotator.character_sequence
  end

  def initialize
    super
  end

  def rotate_sequence_by(amount)
    amount %= @character_sequence.size
    @character_sequence = @character_sequence.rotate(amount)
  end

end
