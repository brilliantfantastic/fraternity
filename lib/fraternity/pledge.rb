require "lotus/validations"

module Fraternity
  class Pledge
    include Lotus::Validations

    attr_accessor :id, :email, :token

    validates :email, presence: true, format: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/
    validates :token, presence: true

    def initialize(attributes={})
      @id, @email, @token = attributes.values_at :id, :email, :token
      @token ||= TemporaryToken.generate_random_token
    end
  end
end
