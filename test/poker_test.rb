require 'minitest/autorun'
require_relative '../lib/poker'

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
    assert_equal 2, @round.players.first.cards.size
  end

  def test_deck_gets_smaller
    skip
    assert_equal 42, @round.deck.size
  end
end

class Poker::CardTest < Minitest::Test
  def setup
    @high_card = Poker::Card.new(:ace, :spades)
    @low_card = Poker::Card.new(2, :hearts)
  end

  def test_card_equivalence
    assert_equal Poker::Card.new(:ace, :spades), @high_card
  end

  def test_card_unequivalence
    refute_equal Poker::Card.new(:king, :spades), @high_card
  end

  def test_card_greater_than
    assert_equal true, @high_card > @low_card
    assert_equal false, @low_card > @high_card
  end

  def test_card_less_than
    assert_equal false, @high_card < @low_card
    assert_equal true, @low_card < @high_card
  end
end
