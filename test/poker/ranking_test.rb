require 'minitest/autorun'
require_relative '../../lib/poker/ranking'

module Poker
  class RankingTest < Minitest::Test
    def setup
      @class = Ranking
    end

    def test_royal_flush?
      suit = :spades
      cards = [
        Card.new(:ace, suit),
        Card.new(:king, suit),
        Card.new(:queen, suit),
        Card.new(:jack, suit),
        Card.new(10, suit)
      ]

      new_cards = [
        Card.new(5, :hearts)
      ]

      assert_equal true, @class.new(cards).royal_flush?
      assert_equal false, @class.new(cards[0..3] + new_cards).royal_flush?
    end

    def test_straight_flush?
      suit = :hearts
      cards = [
        Card.new(:ace, suit),
        Card.new(:king, suit),
        Card.new(:queen, suit),
        Card.new(:jack, suit),
        Card.new(10, suit)
      ]

      extra_cards = [
        Card.new(:ace, :diamonds)
      ]

      assert_equal true, @class.new(cards).straight_flush?
      assert_equal false, @class.new(cards[0..3] + extra_cards).straight_flush?
    end

    def test_quads?
      number = 10
      cards = [
        Card.new(number, :diamonds),
        Card.new(number, :hearts),
        Card.new(number, :spades),
        Card.new(number, :clubs),
      ]

      extra_cards = [
        Card.new(:jack, :clubs),
        Card.new(:ace, :spades)
      ]

      assert_equal true, @class.new(cards).quads?
      assert_equal false, @class.new(cards[0..2] + extra_cards).quads?
    end

    def test_full_house?
      num1, num2 = 2, 3
      filler = [
        Card.new(4, :spades),
        Card.new(5, :spades),
        Card.new(6, :spades)
      ]
      trips = [
        Card.new(num1, :spades),
        Card.new(num1, :hearts),
        Card.new(num1, :diamonds),
      ]
      dubs = [
        Card.new(num2, :diamonds),
        Card.new(num2, :spades)
      ]

      assert_equal false, @class.new(filler + trips).full_house?
      assert_equal false, @class.new(filler + dubs).full_house?
      assert_equal true, @class.new(trips + dubs).full_house?
    end

    def test_flush?
      suit = :spades
      cards = [
        Card.new(3, suit),
        Card.new(2, suit),
        Card.new(4, suit),
        Card.new(6, suit),
        Card.new(8, suit),
      ]

      new_card = [
        Card.new(9, :clubs)
      ]

      assert_equal true, @class.new(cards).flush?
      assert_equal true, @class.new(cards[0..4] + new_card).flush?
    end

    def test_straight?
      cards = [
        Card.new(:ace, SUITS.sample),
        Card.new(:king, SUITS.sample),
        Card.new(:queen, SUITS.sample),
        Card.new(:jack, SUITS.sample),
        Card.new(10, SUITS.sample)
      ]

      extra_cards = [
        Card.new(5, :hearts),
        Card.new(2, :spades)
      ]

      assert_equal true, @class.new(cards + extra_cards).straight?
      assert_equal false, @class.new(cards[0..3] + extra_cards).straight?
    end

    def test_trips?
      number = 10
      cards = [
        Card.new(9, :clubs),
        Card.new(number, :diamonds),
        Card.new(number, :hearts),
        Card.new(number, :spades)
      ]
      extra_cards = [
        Card.new(:jack, :clubs),
        Card.new(:ace, :spades)
      ]

      assert_equal true, @class.new(cards).trips?
      assert_equal false, @class.new(cards[0..2] + extra_cards).trips?
    end

    def test_two_pair?
      cards = [
        Card.new(10, :spades),
        Card.new(10, :diamonds),
        Card.new(:jack, :diamonds),
        Card.new(:ace, :diamonds),
      ]
      extra_cards = [
        Card.new(9, :hearts),
        Card.new(9, :clubs)
      ]

      assert_equal true, @class.new(cards + extra_cards).two_pair?
      assert_equal false, @class.new(cards).two_pair?
    end

    def test_one_pair?
      suit = :hearts
      cards = [
        Card.new(:ace, suit),
        Card.new(:king, suit),
        Card.new(:queen, suit),
        Card.new(:jack, suit),
        Card.new(10, suit)
      ]
      extra_card = [Card.new(:ace, :spades)]

      assert_equal true, @class.new(cards + extra_card).one_pair?
      assert_equal false, @class.new(cards).one_pair?
    end

    def test_high_card
      suit = :aces
      cards = [
        Card.new(2, suit),
        Card.new(3, suit),
        Card.new(4, suit),
        Card.new(7, suit),
        Card.new(9, suit),
        Card.new(:king, suit)
      ]

      assert_equal :king, @class.new(cards).high_card
    end
  end
end
