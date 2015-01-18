require "fraternity/configuration"
require "fraternity/pledge"
require "fraternity/repositories"
require "fraternity/temporary_token"

module Fraternity
  def self.configuration
    @configuration ||= Fraternity::Configuration.new
  end

  def self.configure(initiate=true)
    yield configuration if block_given?
    Repositories.initiation! configuration.database_url if initiate
  end

  def self.rush(params={})
    params[:token] ||= TemporaryToken.generate_random_token
    Fraternity::Pledge.new params
  end

  def self.rush!(params)
    Repositories::PledgeRepository.create self.rush(params)
  end
end
