require_relative 'ranking'

module Poker
  # Determines the real winner or if there is a draw
  class Draw
    attr_reader :winners

    def initialize(players, communal_cards, options={})
      @players = players
      @winner = players[0] if players.size == 1
      @communal_cards = communal_cards
    end

    def royal_flush
      highest_card_on_hand
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

    def players_with_highest_card
      @players.group_by { |p| p.hand.max_by(&:rank).rank }.max[1]
    end
  end
end
