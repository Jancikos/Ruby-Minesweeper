module Game
    $board = nil

    def getBoard
        return $board
    end

    #game options
    def setBoard(difficulty)
        case difficulty
        when 1
            $board = GameBoard.new(4,4)
            markedFieldArr = Game.setField("NORMAL")
            RD.generateBombs($board.field, 5, $board.size, markedFieldArr[0], markedFieldArr[1])
        when 2
            $board = GameBoard.new(9,9)
            markedFieldArr = Game.setField("NORMAL")
            RD.generateBombs($board.field, 35, $board.size, markedFieldArr[0], markedFieldArr[1])
        when 3
            $board = GameBoard.new(19,19)
            markedFieldArr = Game.setField("NORMAL")
            RD.generateBombs($board.field, 100, $board.size, markedFieldArr[0], markedFieldArr[1])
        end
        self.setNumForFields($board.field.length, $board.size)

        return markedFieldArr
    end

    def setField(modeName)
        return UX.setCoordinates(modeName)
    end

    def setEmptyState(x,y,sX, sY)
        if $board.field[[x+sX,y+sY]].num == 0
            $board.field[[x+sX,y+sY]].state = 3
            self.findAllEmptyFields(x+sX,y+sY)
        else
            $board.field[[x+sX,y+sY]].state = 2
        end
    end

    def getSibling(x,y,sX, sY)
        #s = sibling
        if $board.field[[x+sX,y+sY]] != nil
            if $board.field[[x+sX,y+sY]].state == 0
                return true
            end
        end
    end

    #find all empty fields siblings of marked field
    def findAllEmptyFields(x,y)
        for i in 1..8
            case i
            when 1
                if self.getSibling(x,y,-1,-1)
                    self.setEmptyState(x,y,-1,-1)
                end
            when 2
                if self.getSibling(x,y,0,-1)
                    self.setEmptyState(x,y,0,-1)
                end
            when 3
                if self.getSibling(x,y,+1,-1)
                    self.setEmptyState(x,y,+1,-1)
                end
            when 4
                if self.getSibling(x,y,+1,0)
                    self.setEmptyState(x,y,+1,0)
                end
            when 5
                if self.getSibling(x,y,+1,+1)
                    self.setEmptyState(x,y,+1,+1)
                end
            when 6
                if self.getSibling(x,y,0,+1)
                    self.setEmptyState(x,y,0,+1)
                end
            when 7
                if self.getSibling(x,y,-1,+1)
                    self.setEmptyState(x,y,-1,+1)
                end
            when 8
                if self.getSibling(x,y,-1,0)
                    self.setEmptyState(x,y,-1,0)
                end
            else
                puts "ERROR: SOMETHING BAD HAPPENDED"
            end
        end
    end

    #reducing duplicity
    def drawLine(j, i, markedX, markedY)
        self.findAllEmptyFields(markedX,markedY)

        if j == markedX && i == markedY && $board.field[[j,i]].state != 1
            if $board.field[[j,i]].num == 0
                $board.field[[j,i]].state = 3
            else
                $board.field[[j,i]].state = 2
            end
            $board.field[[j,i]].setNumPrint
        else
            if $board.field[[j,i]].state != 0
                $board.field[[j,i]].setNumPrint
            else
                print "* "
            end
        end
    end

    def drawBoard(sizeArr, offsetArr, markedX, markedY)
        puts markedX
        puts markedY
        #column nubmers
        columnTensNums = 0
        columnOnesNums = 0
        #row numbers
        rowTensNums = 0
        rowOnesNums = 0
        #x,y
        x = sizeArr[0]
        y = sizeArr[1]

        x_offset = offsetArr[0]
        y_offset = offsetArr[1]
        puts 

        #first line of numbers
        for i in (0..x + x_offset)
            if i < x_offset
                print " "
            elsif i < 10+x_offset
                print "#{columnTensNums} " #should be 0
            else
                if (i-x_offset).modulo(10) == 0
                    columnTensNums += 1
                end
                print "#{columnTensNums} "
            end
        end

        #line splitting
        puts 

        #second line of numbers
        for i in (0..x + x_offset)
            if i < x_offset
                print " "
            else
                if (i-x_offset).modulo(10) == 0
                    columnOnesNums = 0;
                else
                    columnOnesNums += 1
                end
                print "#{columnOnesNums} "
            end
        end
        puts
        
        #rows
        for i in (0..y)
            if i == 0
                print rowTensNums
                print rowOnesNums
                for j in (0..x)
                    self.drawLine(j, i, markedX, markedY)
                end
                puts 
                rowOnesNums = 1
                next
            else
                print rowTensNums
                print rowOnesNums
                for j in (0..x)
                    self.drawLine(j, i, markedX, markedY)
                end
                puts 

                if (i+1).modulo(10) == 0
                    rowTensNums += 1
                    rowOnesNums = 0
                else
                    rowOnesNums += 1
                end
            end
        end
    end

    #give each field a number
    def setNumForFields(maxsize, boardSize)
        actualSize = 0
        x = 0
        y = 0
        while actualSize != maxsize
            #POSITION `COORDINATES`
            #upper left     `-1,-1`
            #upper          ` 0,-1`
            #upper right    `+1,-1`
            #right          `+1, 0`
            #lower right    `+1,+1`
            #lower          ` 0,+1`
            #lower left     `-1,+1`
            #left           `-1, 0`
            bombsForField = 0
            for i in 1..8
                case i
                when 1
                    if self.getBombSibling(x,y,-1,-1)
                        bombsForField += 1
                    end
                when 2
                    if self.getBombSibling(x,y,0,-1)
                        bombsForField += 1
                    end
                when 3
                    if self.getBombSibling(x,y,+1,-1)
                        bombsForField += 1
                    end
                when 4
                    if self.getBombSibling(x,y,+1,0)
                        bombsForField += 1
                    end
                when 5
                    if self.getBombSibling(x,y,+1,+1)
                        bombsForField += 1
                    end
                when 6
                    if self.getBombSibling(x,y,0,+1)
                        bombsForField += 1
                    end
                when 7
                    if self.getBombSibling(x,y,-1,+1)
                        bombsForField += 1
                    end
                when 8
                    if self.getBombSibling(x,y,-1,0)
                        bombsForField += 1
                    end
                else
                    puts "ERROR: SOMETHING BAD HAPPENDED"
                end
            end
            #set num for field
            $board.field[[x,y]].num = bombsForField

            #coordinates of next field
            #first columns
            x += 1
            if x > boardSize[0]
                #next row
                if y == boardSize[1]
                    break
                end
                x = 0
                y += 1
            end

            
            actualSize += 1
        end
    end

    def getBombSibling(x,y,sX, sY)
        #s = sibling
        if $board.field[[x+sX,y+sY]] != nil
            if $board.field[[x+sX,y+sY]].state == 1
                return true
            end
        end
    end
end
