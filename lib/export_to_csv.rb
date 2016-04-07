require 'csv'
require_relative 'poker/round'

number_of_players, rounds_of_poker, file_name = ARGV

headers = [
  "Round #", "Winning Combination", "Communal Cards", "Winning Hand"
]
number_of_players.to_i.times do |i|
  headers << "Player #{i + 1}"
end

CSV.open(file_name + ".csv", "wb") do |csv|
  csv << headers
  rounds_of_poker.to_i.times do |i|
    round = Poker::Round.new(number_of_players.to_i).play
    row = [
      i,
      (Poker::NUMBERS + Poker::Ranking::RANKS.reverse)[round.winner.rank],
      round.communal_cards.map(&:format).join(", "),
      round.winner.hand.map(&:format).join(", ")
    ]
    round.players.each do |player|
      row << player.hand.map(&:format).join(", ")
    end
    csv << row
  end
end
