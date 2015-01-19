module Fraternity
  class Bidder
    def initialize(pledge)
      @pledge = pledge
    end

    def bid!
      @pledge.invite!
      Repositories::PledgeRepository.persist @pledge
      Fraternity.configuration.send_invite.call @pledge
      @pledge
    end
  end
end
