module Sequenceable

  def get_a_to_space_sequence
    ("a".."z").to_a << " "
  end

  def get_b_to_a_sequence
    (("b".."z").to_a << " ") << "a"
  end

  def get_date_of_today
    require 'date'; Date.today.strftime('%d%m%y')
  end

  def make_random_sequence
    pad_with_zeroes(rand(0...100_000))
  end

  def make_offset_sequence(date)
    get_last_four((date.to_i**2).to_s)
  end

  def get_zero_to_100_000_sequence
    (0...100_000).to_a
  end

  def get_last_four(sequence)
    sequence[-4..-1]
  end

  def pad_with_zeroes(sequence)
    sequence.to_s.rjust(5, "0")
  end

  def get_last_five(sequence)
    sequence[-5..-1]
  end

  def get_last_six(sequence)
    sequence[-6..-1]
  end

  def get_last_seven(sequence)
    sequence[-7..-1]
  end

  def get_last_group(series)
    last_group = { 0 => get_last_four(series),
                   1 => get_last_five(series),
                   2 => get_last_six(series),
                   3 => get_last_seven(series) }
    last_group[series.size % 4]
  end

end
