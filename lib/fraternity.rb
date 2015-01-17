require "fraternity/pledge"
require "fraternity/temporary_token"

module Fraternity
  def self.rush(params={})
    Fraternity::Pledge.new params
  end
end
