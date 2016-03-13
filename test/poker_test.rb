require 'minitest/autorun'
require_relative '../lib/poker_game'

class PokerGameTest < Minitest::Test
  def test_number_of_cards_in_deck
    assert_equal 52, PokerGame.new(5).deck.size
  end

  def test_number_of_players_in_game
    assert_equal 5, PokerGame.new(5).players.size
  end

  def test_uniqueness_of_cards_in_deck
    byebug
  end

  def test_each_player_starts_with_two_cards
  end
end
