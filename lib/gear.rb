class Gear
  attr_reader :keys, :date

  def initialize(keys, date)
    @keys = keys
    @date = date
  end

  def self.get_shifts(key, date)
    new_gear = self.new(key, date)
    new_gear.make_shifts
  end

  def make_keys
    { A: @keys[0..1].to_i,
      B: @keys[1..2].to_i,
      C: @keys[2..3].to_i,
      D: @keys[3..4].to_i }
  end

  def make_offsets
    offsets = square_date.to_s[-4..-1].split("")
    { A: offsets[0].to_i,
      B: offsets[1].to_i,
      C: offsets[2].to_i,
      D: offsets[3].to_i }
  end

  def square_date
    @date.to_i**2
  end

  def make_shifts
    make_keys.reduce({}) do |shifts, (key, value)|
      shifts[key] = value + make_offsets[key]
      shifts
    end
  end

end
