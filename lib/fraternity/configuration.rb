module Fraternity
  class Configuration
    attr_accessor :database_url, :send_invite, :receive_pledge

    def initialize
      @receive_pledge = lambda { |pledge| pledge }
      @send_invite = lambda { |pledge| pledge }
    end
  end
end
