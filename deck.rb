class Deck
  attr_reader :cards

  ORDERED_CARD_SET = %w[
    2
    3
    4
    5
    6
    7
    8
    9
    10
    Jack
    Queen
    King
    Ace
  ].freeze

  NUM_SUITS = 4

  def self.rank(card)
    return -1 if card.nil?

    ORDERED_CARD_SET.index(card)
  end

  def initialize
    @cards = []
    ORDERED_CARD_SET.each do |card|
      NUM_SUITS.times { @cards << card }
    end
  end
end
