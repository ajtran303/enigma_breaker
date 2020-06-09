require "./lib/sequenceable"

class Gear

  include Sequenceable

  attr_reader :keys, :date

  def self.get_shifts(key, date)
    new_gear = new(key, date)
    new_gear.make_shifts
  end

  def initialize(keys, date)
    @keys = keys
    @date = date
  end

  def make_keys
    initial_keys =
      { A: @keys[0..1],
        B: @keys[1..2],
        C: @keys[2..3],
        D: @keys[3..4] }
    initial_keys.transform_values(&:to_i)
  end

  def make_offsets
    offsets = make_offset_sequence(@date).split("")
    offsets =
      { A: offsets[0],
        B: offsets[1],
        C: offsets[2],
        D: offsets[3] }
    offsets.transform_values(&:to_i)
  end

  def make_shifts
    make_keys.merge(make_offsets) do | letter, initial, offset|
     initial + offset
    end
  end

end
