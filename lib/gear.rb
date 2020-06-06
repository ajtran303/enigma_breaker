require "date"

class Gear

  def make_keys(seed)
    { A: seed[0..1].to_i,
      B: seed[1..2].to_i,
      C: seed[2..3].to_i,
      D: seed[3..4].to_i }
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

end
