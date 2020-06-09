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
    { A: @keys[0..1],
      B: @keys[1..2],
      C: @keys[2..3],
      D: @keys[3..4] }.transform_values(&:to_i)
  end

  def make_offsets
    offsets = make_offset_sequence(@date).split("")
    { A: offsets[0],
      B: offsets[1],
      C: offsets[2],
      D: offsets[3] }.transform_values(&:to_i)
  end

  def make_shifts
    # raise("Invalid input!") if @keys.nil? || @date.nil?
    make_keys.merge(make_offsets) do | letter, initial_key, offset|
     initial_key + offset
    end
  end

end
