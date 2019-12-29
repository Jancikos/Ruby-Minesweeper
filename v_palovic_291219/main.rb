require_relative "GameBoard.rb"
require_relative "Player.rb"
require_relative "module-Random.rb"
require_relative "module-Game.rb"
require_relative "module-UX.rb"

include RD
include UX
include Game

$difficulty = UX.setDifficulty

markedFieldArr = Game.setBoard($difficulty)

$board = Game.getBoard

markedX = markedFieldArr[0]
markedY = markedFieldArr[1]

while 1
    system "cls"
    Game.drawBoard($board.size, $board.offset, markedX, markedY)
    markedFieldArr = Game.setField("NORMAL")
    markedX = markedFieldArr[0]
    markedY = markedFieldArr[1]
end

