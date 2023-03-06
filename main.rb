require_relative 'card'
require_relative 'deck'
require_relative 'person'
require_relative 'interface'
require_relative 'dealer'
require_relative 'gamer'
require_relative 'game'

game = Game.new

loop do
  game.start
  game.distribution
  game.bet
  game.gamer_action
  game.result
  game.end_game   
end
