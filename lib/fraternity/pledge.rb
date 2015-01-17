module Fraternity
  class Pledge
    attr_accessor :id, :email

    def initialize(attributes={})
      @id, @email = attributes.values_at :id, :email
    end
  end
end
