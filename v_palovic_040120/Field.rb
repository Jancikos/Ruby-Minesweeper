class Field
    attr_accessor :position, :bombsAround, :state, :flagged
    def initialize(x, y, state, board)
        @position = [x,y]
        @state = state # 0 hidden, 1 bombed, 2 unhidden
        @flagged = false
        @bombsAround = 0
        @board = board
    end

    def setBombsAround
        for x_new in -1..1
            for y_new in -1..1
                incrementBombsAround(x_new,y_new)
            end
        end
    end
    
    def incrementBombsAround(x_new,y_new)
        if !@board.getField(self.position[0] + x_new, self.position[1] + y_new).nil?
            if @board.getField(self.position[0] + x_new, self.position[1] + y_new).state == 1 
                @bombsAround = @bombsAround+1
            end 
        end
    end
end