require_relative "player.rb"
require_relative "mod-options.rb"
require_relative "mod-game.rb"
require_relative "Board.rb"
require_relative "Field.rb"

include Options
include Game

player = Player.new

system "cls"

#show available options
Options.show
Options.chooseOption

#check if custom 
if Options.level == 6
    customOptions = Options.custom

    $X = customOptions[0]
    $Y = customOptions[1]
    $Bombs = customOptions[2]
else
    $X = Options.difficulty[Options.level][:x]
    $Y = Options.difficulty[Options.level][:y]
    $Bombs = Options.difficulty[Options.level][:bombs]
end

#set up board
$main_board = Board.new($X, $Y, Options.offset[:x_out], Options.offset[:y_out],Options.offset[:x_in],Options.offset[:y_in], Options.offset[:coor], $Bombs)

#first load
Game.drawBoard($main_board)

Game.checkAndSetField(player)
Game.generateBombs($main_board, player)
Game.loopBombsAround($main_board)
$main_board.setSurroundState(player.x, player.y)
Game.drawBoard($main_board)

loop do
    Game.drawBoard($main_board)

    if player.flag_mode != Game.checkAndSetField(player)
        next
    end

    #Game Over
    if player.flag_mode == false
        if $main_board.getField(player.x, player.y).state == 1
            Game.end = true
            Game.drawBoard($main_board)
            puts "\nJe mi luto, zasiahol si bombu"
            break
        end
    end

    if player.flag_mode == false
        $main_board.setSurroundState(player.x, player.y)
    end

    if player.flag_mode
        $main_board.getField(player.x, player.y).flagged = !$main_board.getField(player.x, player.y).flagged
    end

end
