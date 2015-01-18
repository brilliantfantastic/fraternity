require "lotus/model/mapper"
require "lotus/model/adapters/sql_adapter"
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

    def self.initiation!(database_url)
      adapter = Lotus::Model::Adapters::SqlAdapter.new(mapping, database_url)
      PledgeRepository.adapter = adapter
      mapping.load!
    end
  end
end
