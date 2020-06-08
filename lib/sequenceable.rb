module Sequenceable

  def get_a_to_space_sequence
    ("a".."z").to_a << " "
  end

  def get_b_to_a_sequence
    (("b".."z").to_a << " ") << "a"
  end

  def get_space_to_z_sequence
    ("a".."z").to_a.prepend " "
  end

  def get_date_of_today
    require 'date'; Date.today.strftime('%d%m%y')
  end

  def make_random_sequence
    rand(0...100_000).to_s.rjust(5, "0")
  end

end
