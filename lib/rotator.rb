require "./lib/sequenceable"

class Rotator

  include Sequenceable

  attr_reader :characters

  def self.get_rotations(amount)
    rotator = new
    rotator.rotate(amount)
    rotator.characters
  end

  def initialize
    @characters = get_a_to_space_sequence
  end

  def rotate(amount)
    amount %= @characters.size
    @characters = @characters.rotate(amount)
  end

end
