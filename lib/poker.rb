module Poker
  SUITS = [:spades, :hearts, :diamonds, :clubs]
  NUMBERS = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

  class Round
    attr_reader :deck, :players, :communal_cards

    def initialize(number_of_players, options = {})
      @deck = Deck.new
      @players = assemble_players(number_of_players)
      @communal_cards = []
      play_poker
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
          player.cards << @deck.pop
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
    def initialize
      @cards = assemble_deck.shuffle
    end

    def size
      @cards.length
    end

    def pop
      @cards.pop
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
    attr_reader :number, :suit

    def initialize(number, suit)
      @number = number
      @suit = suit
    end

    def ==(another_card)
      self.number == another_card.number && self.suit == another_card.suit
    end

    def >(another_card)
      NUMBERS.index(self.number) > NUMBERS.index(another_card.number)
    end

    def <(another_card)
      NUMBERS.index(self.number) < NUMBERS.index(another_card.number)
    end
  end

  class Player
    attr_accessor :cards

    def initialize(name)
      @name = name
      @cards = []
    end
  end
end
