module Poker
  # Representation of an individual poker player
  class Player
    attr_accessor :hand, :rank

    def initialize(name)
      @name = name
      @hand = []
      @rank
    end
  end
end
