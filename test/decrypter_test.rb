require "./test/test_helper"
require "./lib/decrypter"

class DecrypterTest < MiniTest::Test

  def test_it_exists_with_attributes
    decrypter = Decrypter.new
    assert_instance_of Decrypter, decrypter
    assert_equal [], decrypter.ciphers
    assert_nil decrypter.terminal_tokens
  end

end
