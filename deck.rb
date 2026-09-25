class Deck
  attr_reader :cards

  ORDERED_CARD_SET_RANK = {
    2 => 0,
    3 => 1,
    4 => 2,
    5 => 3,
    6 => 4,
    7 => 5,
    8 => 6,
    9 => 7,
    10 => 8,
    "Jack" => 9,
    "Queen" => 10,
    "King" => 11,
    "Ace" => 12
  }.freeze

  NUM_SUITS = 4

  def self.rank(card)
    ORDERED_CARD_SET_RANK[card]
  end

  def initialize
    @cards = []
    ORDERED_CARD_SET_RANK.keys.each do |card|
      NUM_SUITS.times { @cards << card }
    end
  end
end
