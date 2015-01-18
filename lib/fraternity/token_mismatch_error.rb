module Fraternity
  class TokenMismatchError < StandardError
    def initialize(expected_token, actual_token)
      super "Expected token #{expected_token}, but was #{actual_token}"
    end
  end
end
