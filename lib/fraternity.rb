require "fraternity/pledge"
require "fraternity/repositories"
require "fraternity/temporary_token"

module Fraternity
  def self.rush(params={})
    params[:token] ||= TemporaryToken.generate_random_token
    Fraternity::Pledge.new params
  end

  def self.rush!(params)
    Repositories::PledgeRepository.create self.rush(params)
  end
end
