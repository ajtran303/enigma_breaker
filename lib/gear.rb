require "date"

class Gear
  attr_reader :keys, :date

  def initialize(keys=make_random_keys, date=get_date_of_today)
    @keys = keys
    @date = date
  end

  def make_keys
    { A: @keys[0..1].to_i,
      B: @keys[1..2].to_i,
      C: @keys[2..3].to_i,
      D: @keys[3..4].to_i }
  end

  def get_date_of_today
    Date.today.strftime('%d%m%y')
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

  def make_random_keys
    rand(1...100_000).to_s.rjust(5, "0")
  end

end
