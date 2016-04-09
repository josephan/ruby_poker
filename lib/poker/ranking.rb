require_relative 'card'

module Poker
  # Determines the rank of a hand given an array of cards
  class Ranking
    attr_reader :result

    RANKS = [
      :royal_flush, :straight_flush, :quads, :full_house, :flush,
      :straight, :trips, :two_pair, :one_pair
    ].freeze

    def initialize(cards)
      @cards = cards
      @result = find_rank
    end

    def royal_flush?
      suit = popular_suit(@cards)
      @cards.select { |card| card.suit == suit }
        .select { |card| card.rank > 7 }.uniq.length == 5
    end

    def straight_flush?
      temp_cards = duplicate_aces(@cards)
      suit = popular_suit(@cards)
      temp_cards = temp_cards.select { |card| card.suit == suit }
      straight_with_dup_aces?(temp_cards)
    end

    def quads?
      @cards.group_by(&:rank).values.max_by(&:size).size == 4
    end

    def full_house?
      trips? && one_pair?
    end

    def flush?
      @cards.group_by(&:suit).values.max_by(&:size).size >= 5
    end

    def straight?
      temp_cards = duplicate_aces(@cards)
      straight_with_dup_aces?(temp_cards)
    end

    def trips?
      @cards.group_by(&:number).select { |k,v| v.size == 3 }.values.length == 1
    end

    def two_pair?
      @cards.group_by(&:number).select { |k,v| v.size == 2 }.values.length == 2
    end

    def one_pair?
      @cards.group_by(&:number).select { |k,v| v.size == 2 }.values.length == 1
    end

    def high_card
      @cards.sort_by(&:rank).last.number
    end

    private

    def straight_with_dup_aces?(cards)
      temp_cards = duplicate_aces(cards)
      sorted_cards = temp_cards.sort_by(&:rank)
      sorted_cards.map(&:rank).uniq.each_cons(5) do |array|
        return true if array.last - array.first == 4
      end
      false
    end

    def duplicate_aces(cards)
      temp_array = []
      cards.each do |card|
        next unless card.number == :ace
        dup_card = Card.new(:ace, card.suit)
        dup_card.rank = -1
        temp_array << dup_card
      end
      temp_array + cards
    end

    def popular_suit(cards)
      cards.group_by(&:suit).values.max_by(&:size).first.suit
    end

    def find_rank
      RANKS.each do |rank|
        return rank if self.public_send(:"#{rank}?")
      end
      high_card
    end
  end
end
