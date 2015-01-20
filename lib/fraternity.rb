require "fraternity/version"
require "fraternity/bidder"
require "fraternity/configuration"
require "fraternity/perp_error"
require "fraternity/pledge"
require "fraternity/repositories"
require "fraternity/temporary_token"
require "fraternity/token_mismatch_error"

module Fraternity
  def self.configuration
    @configuration ||= Fraternity::Configuration.new
  end

  def self.configure(initiate=true)
    yield configuration if block_given?
    Repositories.initiation! configuration.database_url if initiate
  end

  def self.rush(params={})
    pledge = Repositories::PledgeRepository.find_by_email params[:email]
    if pledge
      pledge
    else
      params[:token] ||= TemporaryToken.generate_random_token
      params[:initiation_number] ||= Time.now.to_i
      Fraternity::Pledge.new params
    end
  end

  def self.rush!(params)
    Repositories::PledgeRepository.create self.rush(params)
  end

  def self.bid!(quota)
    Repositories::PledgeRepository.oldest_uninvited_by_initiation_number(quota).collect do |pledge|
      pledge.bid!
    end
  end

  def self.find(identifier)
    if identifier.is_a? Integer
      return Repositories::PledgeRepository.find_by_id identifier
    end
    Repositories::PledgeRepository.find_by_token identifier
  end
end
