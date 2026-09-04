class Player
  attr_reader :cards, :name

  def initialize(num)
    @name = "Player #{num}"
    @cards = []
  end

  def play_cards(num_cards = 1)
    cards.shift(num_cards).to_a
  end

  def accept_cards(new_cards)
    cards.push(*new_cards)
  end

  def out_of_cards?
    cards.empty?
  end
end
