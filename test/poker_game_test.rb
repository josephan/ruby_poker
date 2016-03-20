require 'minitest/autorun'
require_relative '../lib/poker_game'

class PokerGameTest < Minitest::Test
  def test_number_of_cards_in_deck
    skip
    assert_equal 52, PokerGame.new(5).deck.size
  end

  def test_number_of_players_in_game
    assert_equal 5, PokerGame.new(5).players.size
  end

  def test_uniqueness_of_cards_in_deck
  end

  def test_each_player_starts_with_two_cards
    assert_equal 2, PokerGame.new(5).players.first.cards.size
  end

  def test_deck_gets_smaller
    skip
    assert_equal 42, PokerGame.new(5).deck.size
  end
end
