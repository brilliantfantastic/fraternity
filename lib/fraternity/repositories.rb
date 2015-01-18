require "lotus/model/mapper"
require_relative "repositories/pledge_repository"

module Fraternity
  module Repositories
    @@mapping = Lotus::Model::Mapper.new do
      collection :pledges do
        entity Fraternity::Pledge
        repository PledgeRepository
      end
    end

    def self.mapping
      @@mapping
    end
  end
end
