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
      [
        @cards.include?(Card.new(:ace, suit)),
        @cards.include?(Card.new(:king, suit)),
        @cards.include?(Card.new(:queen, suit)),
        @cards.include?(Card.new(:jack, suit)),
        @cards.include?(Card.new(10, suit))
      ].all?
    end

    def straight_flush?
      suit = popular_suit(duplicate_aces(@cards))
      @cards.each_with_index do |card, ind|
        @cards.delete_at(2) if card.suit != suit
      end
      straight?
    end

    def quads?
      @cards.group_by(&:rank).values.max_by(&:size).size == 4
    end

    def full_house?
      if trips?
        @cards -= @cards.group_by(&:number).values.max_by(&:size)
        one_pair?
      else
        false
      end
    end

    def flush?
      @cards.group_by(&:suit).values.max_by(&:size).size >= 5
    end

    def straight?
      @cards = duplicate_aces(@cards)
      sorted_cards = @cards.sort_by(&:rank)
      sorted_cards.map(&:rank).uniq.each_cons(5) do |array|
        return true if array.last - array.first == 4
      end
      false
    end

    def trips?
      @cards.group_by(&:number).values.max_by(&:size).size == 3
    end

    def two_pair?
      @cards.group_by(&:number).select { |k,v| v.size == 2 }.values.length == 2
    end

    def one_pair?
      @cards.group_by(&:number).values.max_by(&:size).size == 2
    end

    def high_card
      @cards.sort_by(&:rank).last.number
    end

    private

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
