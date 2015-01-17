module Fraternity
  class Pledge
    attr_accessor :id, :email, :token

    def initialize(attributes={})
      @id, @email, @token = attributes.values_at :id, :email, :token
      @token ||= TemporaryToken.generate_random_token
    end
  end
end
