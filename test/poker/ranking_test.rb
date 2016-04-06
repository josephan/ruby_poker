require 'minitest/autorun'
require_relative '../../lib/poker/ranking'

module Poker
  class RankingTest < Minitest::Test
    def setup
      @ranking = Poker::Ranking.new
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

      assert_equal true, @ranking.royal_flush?(cards)
      assert_equal false, @ranking.royal_flush?(cards[0..3] + new_cards)
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

      assert_equal true, @ranking.straight_flush?(cards)
      assert_equal false, @ranking.straight_flush?(cards[0..3] + extra_cards)
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

      assert_equal true, @ranking.quads?(cards)
      assert_equal false, @ranking.quads?(cards[0..2] + extra_cards)
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

      assert_equal false, @ranking.full_house?(filler + trips)
      assert_equal false, @ranking.full_house?(filler + dubs)
      assert_equal true, @ranking.full_house?(trips + dubs)
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

      assert_equal true, @ranking.flush?(cards)
      assert_equal true, @ranking.flush?(cards[0..4] + new_card)
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

      assert_equal true, @ranking.straight?(cards + extra_cards)
      assert_equal false, @ranking.straight?(cards[0..3] + extra_cards)
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

      assert_equal true, @ranking.trips?(cards)
      assert_equal false, @ranking.trips?(cards[0..2] + extra_cards)
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

      assert_equal true, @ranking.two_pair?(cards + extra_cards)
      assert_equal false, @ranking.two_pair?(cards)
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

      assert_equal true, @ranking.one_pair?(cards + extra_card)
      assert_equal false, @ranking.one_pair?(cards)
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

      assert_equal :king, @ranking.high_card(cards)
    end
  end
end
