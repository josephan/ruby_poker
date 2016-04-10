require 'minitest/autorun'
require 'ostruct'
require_relative '../../lib/poker/round'

module Poker
  class DrawTest < Minitest::Test
    def setup
      @player1 = Player.new("player1")
      @player2 = Player.new("player1")
      @player3 = Player.new("player2")
    end

    def card(number)
      Card.new(number, SUITS.sample)
    end

    def test_players_with_highest_card
      @player1.hand = [card(5), card(10)]
      @player2.hand = [card(8), card(:ace)]
      @player3.hand = [card(5), card(:king)]
      players = [@player1, @player2, @player3]
      player4 = Player.new("player4")
      player4.hand = [card(2), card(:ace)]

      assert_equal [@player2], Draw.new(players).players_with_highest_card
      assert_equal [@player2, player4], Draw.new(players << player4).players_with_highest_card
    end
  end
end
