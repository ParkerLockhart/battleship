require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/gameplay'
require './lib/computer'
require './lib/player'

game1 = Gameplay.new
game1.greeting
game1.start
computer = Computer.new
player = Player.new
computer.setup_cruiser
computer.setup_submarine
player.setup
