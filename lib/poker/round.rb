require_relative 'deck'
require_relative 'player'
require_relative 'ranking'

module Poker
  # A round of a poker game that ties it all together
  class Round
    attr_reader :deck, :players, :communal_cards, :winner

    def initialize(number_of_players, _options = {})
      @deck = Deck.new
      @players = assemble_players(number_of_players)
      @communal_cards = []
    end

    def play
      play_poker
      rank_hands
      declare_winner
      self
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

    def declare_winner
      @winner = @players.max_by(&:rank)
    end

    def rank_hands
      @players.each do |player|
        hand_rank = Ranking.new(@communal_cards + player.hand).result
        player.rank = index_of_rank(hand_rank)
      end
    end

    def index_of_rank(rank)
      (NUMBERS + Ranking::RANKS.reverse).index(rank)
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

