module Ranking
  def puts_communals
    @communal_cards
  end
end

class PokerGame
  attr_reader :deck, :players, :communal_cards

  include Ranking

  def initialize(number_of_players, options = {})
    @deck = Deck.new
    @players = assemble_players(number_of_players)
    @communal_cards = []
    puts "Dealing cards"
    deal_cards
    puts "Burning card"
    burn_card
    puts "The Flop"
    the_flop
    puts "Burning Card"
    burn_card
    puts "The Turn"
    reveal_card
    puts "Burning Card"
    burn_card
    puts "The River"
    reveal_card
  end

  private

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

class Player
  attr_accessor :cards

  def initialize(name)
    @name = name
    @cards = []
  end
end
