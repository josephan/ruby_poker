require 'minitest/autorun'
require_relative '../lib/poker/card'

module Poker
  class CardTest < Minitest::Test
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
end
