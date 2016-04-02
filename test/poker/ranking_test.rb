require 'minitest/autorun'
require_relative '../../lib/poker/ranking'

module Poker
  class RankingTest < Minitest::Test
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
        Poker::Card.new(:ace, Poker::SUITS.sample)
      ]

      assert_equal 2, Poker::Ranking.duplicate_aces(cards).length
    end
  end
end
