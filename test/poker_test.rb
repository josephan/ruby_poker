require 'minitest/autorun'
require_relative '../lib/poker'

class PokerTest < Minitest::Test
  def test_number_of_cards_in_deck
    assert_equal 52, Poker.new(5).deck.size
  end

  def test_number_of_players_in_game
  end

  def test_uniqueness_of_cards_in_deck
  end

end
