module Poker
  class Ranking
    RANKS = [
      :royal_flush, :straight_flush, :quads, :full_house, :flush,
      :straight, :trips, :two_pair, :one_pair, :high_card
    ]

    def assign_rank(cards)
    end

    def royal_flush(cards)
      suit = popular_suit(cards)
      [
        cards.include?(Card.new(:ace, suit)),
        cards.include?(Card.new(:king, suit)),
        cards.include?(Card.new(:queen, suit)),
        cards.include?(Card.new(:jack, suit)),
        cards.include?(Card.new(10, suit))
      ].all?
    end

    def straight_flush(cards)
      suit = popular_suit(cards)
      cards.each_with_index do |card, ind|
        cards[:ind].delete(card) if card.suit != suit
      end
      straight(cards)
    end

    def quads
    end

    def full_house
    end

    def flush
    end

    def straight(cards)
      cards = duplicate_aces(cards)
      sorted_cards = cards.sort_by { |card| card.rank }
      sorted_cards.map { |card| card.rank }.uniq.each_cons(5) do |array|
        return true if array.last - array.first == 5
      end
      false
    end

    def trips
    end

    def two_pair
    end

    def one_pair
    end

    def high_card
    end

    def duplicate_aces(cards)
      temp_array = []
      cards.each do |card|
        if card.number == :ace
          dup_card = Card.new(:ace, card.suit)
          dup_card.rank = -1
          temp_array << dup_card
        end
      end
      temp_array + cards
    end

    def popular_suit(cards)
      cards.group_by(&:suit).values.max_by(&:size).first.suit
    end

    def same_suit?(cards)
      suit = cards[0].suit
      cards.all? { |card| card.suit == suit } ? suit : false
    end
  end
end
