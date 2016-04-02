require_relative '../poker'
require_relative 'card'

module Poker
  # A deck of cards
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
end
