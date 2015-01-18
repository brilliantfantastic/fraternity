module Fraternity
  class Configuration
    attr_accessor :database_url, :send_invite

    def initialize
      @send_invite = lambda { |pledge| pledge }
    end
  end
end
