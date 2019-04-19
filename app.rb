require_relative './lib/player'
require_relative './lib/game'

g = Game.new

loop do
  g.play
  break if g.victory == 'yes mamen'
end
