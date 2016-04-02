require_relative '../poker'

module Poker
  # Representation of a playing card in a standard 52 card deck
  # Look into eql, hash
  class Card
    attr_reader :number, :suit
    attr_accessor :rank

    def initialize(number, suit)
      @number = number
      @suit = suit
      @rank = NUMBERS.index(self.number)
    end

    def ==(other)
      number == other.number && suit == other.suit
    end

    def >(other)
      @rank > other.rank
    end

    def <(other)
      @rank < other.rank
    end
  end
end
