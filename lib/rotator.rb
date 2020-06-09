require "./lib/sequenceable"

class Rotator

  include Sequenceable

  attr_reader :character_sequence

  def self.get_rotations(amount)
    rotator = new
    rotator.rotate_sequence_by(amount)
    rotator.character_sequence
  end

  def initialize
    @character_sequence = get_a_to_space_sequence
  end

  def rotate_sequence_by(amount)
    amount %= @character_sequence.size
    @character_sequence = @character_sequence.rotate(amount)
  end

end
