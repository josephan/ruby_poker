module Poker
  SUITS = [:spades, :hearts, :diamonds, :clubs]
  NUMBERS = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

  module Ranking
    RANKS = [
      :high_card, :one_pair, :two_pair, :trips, :straight, :flush,
      :full_house, :quads, :straight_flush, :royal_flush
    ]

    def assign_rank(cards)
    end

    def royal_flush(cards)
      suit = popular_suit(cards)
      [
        cards.include(Card.new(:ace, suit)),
        cards.include(Card.new(:king, suit)),
        cards.include(Card.new(:queen, suit)),
        cards.include(Card.new(:jack, suit)),
        cards.include(Card.new(10, suit))
      ].all?
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

    def high_card
    end

    def popular_suit(cards)
      cards.group_by(&:suit).values.max_by(&:size).first.suit
    end

    def same_suit?(cards)
      suit = cards[0].suit
      cards.all? { |card| card.suit == suit } ? suit : false
    end
  end

  class Round
    attr_reader :deck, :players, :communal_cards

    def initialize(number_of_players, options = {})
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
        players << Player.new("Player #{n+1}", )
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

  class Deck
    attr_reader :cards

    def initialize
      @cards = assemble_deck.shuffle
    end

    def size
      @cards.length
    end

    def pop
      @cards.pop
    end

    def sample(number)
      @cards.sample(number)
    end

    private

    def assemble_deck
      deck = []
      SUITS.each do |suit|
        NUMBERS.each do |number|
          deck << Card.new(number, suit)
        end
      end
      deck
    end

  end

  class Card
    attr_reader :number, :suit, :rank

    def initialize(number, suit)
      @number = number
      @suit = suit
      @rank = NUMBERS.index(self.number)
    end

    def ==(another_card)
      self.number == another_card.number && self.suit == another_card.suit
    end

    def >(another_card)
      @rank > another_card.rank
    end

    def <(another_card)
      @rank < another_card.rank
    end
  end

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
