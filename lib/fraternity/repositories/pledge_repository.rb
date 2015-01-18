require 'lotus/repository'

module Fraternity
  module Repositories
    class PledgeRepository
      include Lotus::Repository

      def self.oldest_uninvited_by_initiation_number(limit=8)
        query do
          where(invited_at: nil).
            order(:initiation_number)
        end.limit(limit)
      end
    end
  end
end
