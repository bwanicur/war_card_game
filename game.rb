require_relative "./deck"
require_relative "./player"

class Game
  def initialize(num_players)
    deck = Deck.new
    @players = num_players.times.map { |n| Player.new(n + 1) }
    # if we do not randomize (shuffle) the cards, players can end up with identical hands
    deck.cards.shuffle.each_with_index do |card, index|
      players[index % num_players].accept_cards([card])
    end
  end

  def play
    round = 1
    while players.count > 1
      puts "Round #{round}"
      winner, pot = select_winners(players, [])
      winner.accept_cards(pot.shuffle) # shuffle to be non-deterministic
      players.reject!(&:out_of_cards?)
      round += 1
    end

    # only one player now - declare winner
    puts " ----------------------- "
    puts "#{players.first.name} wins the game!"
  end

  private

  attr_reader :players

  def select_winners(contenders, pot = [], played_cards = {})
    contenders.each do |player|
      card = player.play_cards.first
      next unless card # out of cards - their existing face up card stands

      pot << card
      played_cards[player] = card
    end

    highest_card = contenders.map { |player| played_cards[player] }.max_by { |card| Deck.rank(card) }
    winners = contenders.select { |player| played_cards[player] == highest_card }
    return [winners.first, pot] if winners.size == 1

    # Every player still in the war is out of cards - very unlikely
    # Full confession - Claude caught this - I did not think about this scenario.
    return [winners.sample, pot] if winners.none? { |player| player.cards.any? }

    winners.each do |player|
      # never spend a player's last card face down - rule 4D requires it be played face up
      zero_to_three_cards = [3, [player.cards.size - 1, 0].max].min
      pot.concat(player.play_cards(zero_to_three_cards))
    end
    select_winners(winners, pot, played_cards)
  end
end