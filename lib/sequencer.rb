require "./lib/sequenceable"

class Sequencer
  include Sequenceable

  attr_reader :character_sequence

  def initialize
    @character_sequence = get_a_to_space_sequence
  end

end
