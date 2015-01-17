require "fraternity/pledge"

module Fraternity
  def self.rush(params)
    Fraternity::Pledge.new params
  end
end
