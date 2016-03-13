class PokerGame
  attr_reader :deck, :players

  def initialize(players)
    @deck = Deck.new
  end
end

class Deck
  def initialize
    @cards = assemble_deck
  end

  def size
    @cards.length
  end

  private

  def suits
    ["spades", "hearts", "diamonds", "clubs"]
  end

  def numbers
    [2, 3, 4, 5, 6, 7, 8, 9, 10, "Jack", "Queen", "King", "Ace"]
  end

  def assemble_deck
    deck = []
    suits.each do |suit|
      numbers.each do |number|
        deck << Card.new(number, suit)
      end
    end
    deck
  end

end

class Card
  def initialize(number, suit)
    @number = number
    @suit = suit
  end
end

class Players
  def initialize(cards)
  end

end
