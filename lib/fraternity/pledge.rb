require "lotus/validations"

module Fraternity
  class Pledge
    include Lotus::Validations

    attr_accessor :id, :email, :token, :initiation_number

    validates :email, presence: true, format: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/
    validates :token, presence: true
    validates :initiation_number, presence: true

    def initialize(attributes={})
      @id, @email, @token, @initiation_number = attributes.values_at :id, :email, :token, :initiation_number
    end
  end
end
