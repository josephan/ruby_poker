require 'minitest/autorun'
require_relative '../lib/poker'

class Poker::RankingTest < Minitest::Test
  def test_royal_flush
    suit = :spades
    cards = [
      Poker::Card.new(:ace, suit),
      Poker::Card.new(:king, suit),
      Poker::Card.new(:queen, suit),
      Poker::Card.new(:jack, suit),
      Poker::Card.new(10, suit)
    ]

    new_cards = [
      Poker::Card.new(5, :hearts)
    ]

    assert_equal true, Poker::Ranking.royal_flush(cards)
    assert_equal false, Poker::Ranking.royal_flush(cards[0..3] + new_cards)
  end

  def test_straight_flush
    cards = [

    ]

    assert_equal true, Poker::Ranking.straight_flush(cards)
    assert_equal false, Poker::Ranking.straight_flush(cards + new_cards)
  end

  def test_straight
    cards = [
      Poker::Card.new(:ace, Poker::SUITS.sample),
      Poker::Card.new(:king, Poker::SUITS.sample),
      Poker::Card.new(:queen, Poker::SUITS.sample),
      Poker::Card.new(:jack, Poker::SUITS.sample),
      Poker::Card.new(10, Poker::SUITS.sample)
    ]

    extra_cards = [
      Poker::Card.new(5, :hearts),
      Poker::Card.new(2, :spades)
    ]

    assert_equal true, Poker::Ranking.straight(cards + extra_cards)
    assert_equal false, Poker::Ranking.straight(cards[0..3] + extra_cards)
  end

  def test_duplicate_aces
    cards = [
      Poker::Card.new(:ace, Poker::SUITS.sample),
    ]

    assert_equal 2, Poker::Ranking.duplicate_aces(cards).length
  end
end

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
