require 'minitest/autorun'
require_relative '../lib/poker/round'

class Poker::RoundTest < Minitest::Test
  def setup
    @round = Poker::Round.new(5)
  end

  def test_number_of_cards_in_deck
    skip
    assert_equal 52, @round.deck.size
  end

  def test_number_of_players_in_game
    assert_equal 5, @round.players.size
  end

  def test_uniqueness_of_cards_in_deck
    skip
  end

  def test_each_player_starts_with_two_cards
    assert_equal 2, @round.players.first.hand.size
  end

  def test_deck_gets_smaller
    skip
    assert_equal 42, @round.deck.size
  end
end
