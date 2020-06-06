require "date"

class Gear
  attr_reader :teeth

  def initialize(teeth)
    @teeth = teeth
  end

  def make_keys
    { A: @teeth[0..1].to_i,
      B: @teeth[1..2].to_i,
      C: @teeth[2..3].to_i,
      D: @teeth[3..4].to_i }
  end

  def get_date_of_today
    date = Date.today
    date.strftime('%d%m%y')
  end

  def make_offsets
    offsets = square_date.to_s[-4..-1].split("")
    { A: offsets[0].to_i,
      B: offsets[1].to_i,
      C: offsets[2].to_i,
      D: offsets[3].to_i }
  end

  def square_date
    get_date_of_today.to_i**2
  end

  def make_shifts
    make_keys.reduce({}) do |shifts, (key, value)|
      shifts[key] = value + make_offsets[key]
      shifts
    end
  end

end
