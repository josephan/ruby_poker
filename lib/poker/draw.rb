module Poker
  # Determines the real winner or if there is a draw
  class Draw
    attr_reader :winners

    def initialize(players)
      @players = players
      @winner = players[0] if players.size == 1
    end

    def royal_flush
    end

    def straight_flush
    end

    def quads
    end

    def full_house
    end

    def flush
    end

    def straight
    end

    def trips
    end

    def two_pair
    end

    def one_pair
    end

    def highest_card_on_hand
      p
    end
  end
end
