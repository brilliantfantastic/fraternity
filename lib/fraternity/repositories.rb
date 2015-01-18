require "lotus/model/mapper"
require "lotus/model/adapters/sql_adapter"
require_relative "repositories/pledge_repository"

module Fraternity
  module Repositories
    @@mapping = Lotus::Model::Mapper.new do
      collection :pledges do
        entity Fraternity::Pledge
        repository PledgeRepository

        attribute :id,                  Integer
        attribute :email,               String
        attribute :token,               String
        attribute :initiation_number,   Integer
        attribute :invited_at,          DateTime
        attribute :accepted_at,         DateTime
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
