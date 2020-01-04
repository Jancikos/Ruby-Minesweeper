module Game
    
    attr_accessor :end
    @end = false

    def drawBoard(board)
        system "cls"
        col_first_num = 0
        row_first_num = 0

        #rows
        for i in 0...$main_board.full_size[1] do
            #y_off_out ... line break
            if i < $main_board.getOffset[:y_out]
                puts ""
                next
            end

            j = -1
            #columns
            while j < $main_board.full_size[0]-1 do
                j+= 1
                # x_off_out ... first spaces
                if j < $main_board.getOffset[:x_out]
                    print " "
                    next
                end

                #first row of numbers
                if i - $main_board.getOffset[:y_out] == 0
                    #coor space
                    if j < $main_board.offsets[0]
                        print " "
                    else
                        if (j - $main_board.offsets[0]).modulo(10) == 0 && (j - $main_board.offsets[0]) >= 10
                            row_first_num += 1
                        end
                        print " #{row_first_num}"
                    end
                    next
                end

                #second row of numbers
                if i - $main_board.getOffset[:y_out] == 1
                    #coor space
                    if j < $main_board.offsets[0]
                        print " "
                    else
                        print " #{(j - $main_board.offsets[0]).modulo(10)}"
                    end
                    next
                end

                # y_off_in ... line break between row numbers and gameboard
                if (i - 2 - $main_board.getOffset[:y_out]) < $main_board.getOffset[:y_in]
                    break
                else
                    #first column number
                    if (i - $main_board.offsets[1]).modulo(10) == 0 && (i - $main_board.offsets[1]) >= 10
                        col_first_num += 1
                    end
                    print "#{col_first_num}"
                    j+= 1

                    #second column number
                    print "#{(i - $main_board.offsets[1]).modulo(10)}"
                    j+=1

                    #x offset inside between column of numbers and gameboard
                    for k in 0...$main_board.getOffset[:x_in] do
                        print " "
                    end
                    j+=$main_board.getOffset[:x_in]

                    while j < $main_board.full_size[0]
                        y_field = i - $main_board.offsets[1]
                        x_field = j - $main_board.offsets[0]
                        
                        if $main_board.draw_count == 0
                            $main_board.fields[[x_field, y_field]] = Field.new(x_field, y_field, 0, $main_board)
                        end

                        #symbols drawing
                        case $main_board.getField(x_field, y_field).state
                        when 1
                            if @end
                                print " X"
                            elsif $main_board.getField(x_field, y_field).flagged
                                print " F"
                            else
                                print " *"
                            end
                        when 2
                            if $main_board.getField(x_field, y_field).bombsAround != 0
                                print " #{$main_board.getField(x_field, y_field).bombsAround}"
                            else
                                print "  "
                            end
                        else
                            if $main_board.getField(x_field, y_field).flagged
                                print " F"
                            else
                                print " *"
                            end
                        end
                        j+=1
                    end
                end
            end
            puts ""
        end
        $main_board.draw_count += 1
    end

    def checkAndSetField(player)

        if player.flag_mode
            puts "Flag MODE"
        end

        puts "\n X: "
        player.x = gets.chomp
        puts "\n Y: "
        player.y = gets.chomp
        

        if player.x == "" && player.y == ""
            player.flag_mode = !player.flag_mode 
        else
            player.x = player.x.to_i
            player.y = player.y.to_i
        end

        return player.flag_mode

    end

    def generateBombs(board, player)
        i = 0

        loop do
            #end generating
            if i >= board.bombs
                break
            end

            random_x = rand(0...board.x)
            random_y = rand(0...board.y)

            #ifp state is already set to 1 or bombs should be place on field which player chose, skip this iteration
            if board.getField(random_x, random_y).state == 1 || board.getField(random_x, random_y) == board.getField(player.x, player.y)
                next
            else
                board.getField(random_x, random_y).state = 1
            end

            i += 1
        end
    end

    def loopBombsAround(board)
        for x in 0...board.x
            for y in 0...board.y
                if board.getField(x,y).state != 1
                    board.getField(x,y).setBombsAround
                end
            end
        end
    end
end