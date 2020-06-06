require "./test/test_helper"
require "./lib/encrypter"

class EncrypterTest < MiniTest::Test

  def test_it_exists_with_attributes
    encrypter = Encrypter.new
    assert_instance_of Encrypter, encrypter
  end

end
