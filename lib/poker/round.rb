require_relative 'deck'
require_relative 'player'
require_relative 'ranking'

module Poker
  # A round of a poker game that ties it all together
  class Round
    attr_reader :deck, :players, :communal_cards

    def initialize(number_of_players, _options = {})
      @deck = Deck.new
      @players = assemble_players(number_of_players)
      @communal_cards = []
      play_poker
      rank_hands
    end

    private

    def play_poker
      deal_cards
      burn_card
      the_flop
      burn_card
      reveal_card
      burn_card
      reveal_card
    end

    def rank_hands
      @players.each do |player|
      end
    end

    def assemble_players(number_of_players)
      players = []
      number_of_players.times do |n|
        players << Player.new("Player #{n + 1}")
      end
      players
    end

    def deal_cards
      2.times do
        @players.each do |player|
          player.hand << @deck.pop
        end
      end
    end

    def burn_card
      @deck.pop
    end

    def the_flop
      3.times do
        reveal_card
      end
    end

    def reveal_card
      @communal_cards << @deck.pop
    end
  end
end
