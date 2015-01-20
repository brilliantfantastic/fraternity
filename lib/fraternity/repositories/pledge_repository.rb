require 'lotus/repository'

module Fraternity
  module Repositories
    class PledgeRepository
      include Lotus::Repository

      def self.find_by_id(id)
        query do
          where(id: id)
        end.first
      end

      def self.find_by_email(email)
        query do
          where(email: email)
        end.first
      end

      def self.find_by_token(token)
        query do
          where(token: token)
        end.first
      end

      def self.oldest_uninvited_by_initiation_number(limit=8)
        query do
          where(invited_at: nil).
            order(:initiation_number)
        end.limit(limit)
      end
    end
  end
end
