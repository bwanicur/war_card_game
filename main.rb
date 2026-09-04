# I've choosen not to add tests as that was not part of the requirements and there is limited time.
require_relative "./game"

# validate input
VALID_PLAYER_COUNTS = [2, 4].freeze
num_players = ARGV[0] ? Integer(ARGV[0], exception: false) : 2
unless VALID_PLAYER_COUNTS.include?(num_players)
  abort "Only 2 or 4 players allowed - Usage: ruby main.rb [#{VALID_PLAYER_COUNTS.join('|')}]"
end

Game.new(num_players).play
