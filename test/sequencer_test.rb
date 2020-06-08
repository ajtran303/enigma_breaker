require "./test/test_helper"
require "./lib/sequencer"

class SequencerTest < MiniTest::Test

  def test_it_exists_with_attributes
    sequencer = Sequencer.new
    assert_instance_of Sequencer, sequencer
    expected = ("a".."z").to_a << " "
    assert_equal expected, sequencer.character_sequence
  end

end
