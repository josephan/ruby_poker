module Poker
  # Look into eql, hash
  class Card
    attr_reader :number, :suit
    attr_accessor :rank

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
