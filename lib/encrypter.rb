class Encrypter

  def group_tokens(tokens)
    grouped_tokens = []
    tokens.each_slice(4) {|token_group| grouped_tokens << token_group}
    grouped_tokens
  end

end