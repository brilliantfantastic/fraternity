require "lotus/model"
require "lotus/validations"

module Fraternity
  class Pledge
    include Lotus::Entity
    include Lotus::Validations

    attributes :email, :token

    validates :email, presence: true, format: /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/
    validates :token, presence: true
  end
end
