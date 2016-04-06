require 'minitest/autorun'
require_relative '../../lib/poker/ranking'

module Poker
  class RankingTest < Minitest::Test
    def setup
      @class = Poker::Ranking
    end

    def test_royal_flush?
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

      assert_equal true, @class.new(cards).royal_flush?
      assert_equal false, @class.new(cards[0..3] + new_cards).royal_flush?
    end

    def test_straight_flush?
      suit = :hearts
      cards = [
        Poker::Card.new(:ace, suit),
        Poker::Card.new(:king, suit),
        Poker::Card.new(:queen, suit),
        Poker::Card.new(:jack, suit),
        Poker::Card.new(10, suit)
      ]

      extra_cards = [
        Poker::Card.new(:ace, :diamonds)
      ]

      assert_equal true, @class.new(cards).straight_flush?
      assert_equal false, @class.new(cards[0..3] + extra_cards).straight_flush?
    end

    def test_quads?
      number = 10
      cards = [
        Poker::Card.new(number, :diamonds),
        Poker::Card.new(number, :hearts),
        Poker::Card.new(number, :spades),
        Poker::Card.new(number, :clubs),
      ]

      extra_cards = [
        Poker::Card.new(:jack, :clubs),
        Poker::Card.new(:ace, :spades)
      ]

      assert_equal true, @class.new(cards).quads?
      assert_equal false, @class.new(cards[0..2] + extra_cards).quads?
    end

    def test_full_house?
      num1, num2 = 2, 3
      filler = [
        Poker::Card.new(4, :spades),
        Poker::Card.new(5, :spades),
        Poker::Card.new(6, :spades)
      ]
      trips = [
        Poker::Card.new(num1, :spades),
        Poker::Card.new(num1, :hearts),
        Poker::Card.new(num1, :diamonds),
      ]
      dubs = [
        Poker::Card.new(num2, :diamonds),
        Poker::Card.new(num2, :spades)
      ]

      assert_equal false, @class.new(filler + trips).full_house?
      assert_equal false, @class.new(filler + dubs).full_house?
      assert_equal true, @class.new(trips + dubs).full_house?
    end

    def test_flush?
      suit = :spades
      cards = [
        Poker::Card.new(3, suit),
        Poker::Card.new(2, suit),
        Poker::Card.new(4, suit),
        Poker::Card.new(6, suit),
        Poker::Card.new(8, suit),
      ]

      new_card = [
        Poker::Card.new(9, :clubs)
      ]

      assert_equal true, @class.new(cards).flush?
      assert_equal true, @class.new(cards[0..4] + new_card).flush?
    end

    def test_straight?
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

      assert_equal true, @class.new(cards + extra_cards).straight?
      assert_equal false, @class.new(cards[0..3] + extra_cards).straight?
    end

    def test_trips?
      number = 10
      cards = [
        Poker::Card.new(9, :clubs),
        Poker::Card.new(number, :diamonds),
        Poker::Card.new(number, :hearts),
        Poker::Card.new(number, :spades)
      ]
      extra_cards = [
        Poker::Card.new(:jack, :clubs),
        Poker::Card.new(:ace, :spades)
      ]

      assert_equal true, @class.new(cards).trips?
      assert_equal false, @class.new(cards[0..2] + extra_cards).trips?
    end

    def test_two_pair?
      cards = [
        Poker::Card.new(10, :spades),
        Poker::Card.new(10, :diamonds),
        Poker::Card.new(:jack, :diamonds),
        Poker::Card.new(:ace, :diamonds),
      ]
      extra_cards = [
        Poker::Card.new(9, :hearts),
        Poker::Card.new(9, :clubs)
      ]

      assert_equal true, @class.new(cards + extra_cards).two_pair?
      assert_equal false, @class.new(cards).two_pair?
    end

    def test_one_pair?
      suit = :hearts
      cards = [
        Poker::Card.new(:ace, suit),
        Poker::Card.new(:king, suit),
        Poker::Card.new(:queen, suit),
        Poker::Card.new(:jack, suit),
        Poker::Card.new(10, suit)
      ]
      extra_card = [Poker::Card.new(:ace, :spades)]

      assert_equal true, @class.new(cards + extra_card).one_pair?
      assert_equal false, @class.new(cards).one_pair?
    end

    def test_high_card
      suit = :aces
      cards = [
        Poker::Card.new(2, suit),
        Poker::Card.new(3, suit),
        Poker::Card.new(4, suit),
        Poker::Card.new(7, suit),
        Poker::Card.new(9, suit),
        Poker::Card.new(:king, suit)
      ]

      assert_equal :king, @class.new(cards).high_card
    end
  end
end
