module Poker
  class Player
    attr_accessor :hand, :rank

    include Ranking

    def initialize(name)
      @name = name
      @hand = []
      @rank
    end
  end
end
