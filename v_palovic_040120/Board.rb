class Board
    attr_accessor :x, :y, :full_size, :offsets, :draw_count, :fields, :bombs
    def initialize(x,y,x_off_out, y_off_out, x_off_in,y_off_in, coor_off, bombs)
        @x = x
        @y = y
        @x_off_out = x_off_out
        @y_off_out = y_off_out
        @x_off_in = x_off_in
        @y_off_in =y_off_in
        @coor_off = coor_off
        @full_size = [@x+@x_off_out+@x_off_in+@coor_off, @y+@y_off_in+@y_off_out+coor_off]
        @offsets = [@x_off_out+x_off_in+@coor_off, @y_off_out+y_off_in+@coor_off]
        @bombs = bombs
        @draw_count = 0
        @fields = Hash.new
    end

    def getOffset
        {x_out:@x_off_out, y_out:@y_off_out, x_in:@x_off_in, y_in:@y_off_in, coor:@coor_off}
    end

    def getField(x,y)
        return @fields[[x,y]]
    end

    def setSurroundState(x,y)
        getField(x,y).state = 2

        unless getField(x,y).nil?
            x_new = -1
            while x_new <= 1
                y_new = -1
                while y_new <= 1
                    unless getField(x+x_new,y+y_new).nil?
                        if getField(x+x_new,y+y_new).state != 1
                            
                            if getField(x,y).bombsAround == 0 && getField(x+x_new,y+y_new).state == 0
                                self.setSurroundState(x+x_new,y+y_new)
                            end
                        end
                    end
                    y_new += 1
                end
                x_new += 1
            end 
        end
    end
end