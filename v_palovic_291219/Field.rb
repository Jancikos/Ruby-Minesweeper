class Field
    attr_accessor :coordinates, :state, :num
    def initialize(x, y, state, num)
        @coordinates = [x, y]
        @state = state #0 - hidden, 1 - hidden+bombed, 2 - showed, 3- showed+empty,4 - flagged
        @num = num

        if @state == 0
            self.defaultPrint()
        end
    end

    
    def defaultPrint
        print "* "
    end

    public
    def setNumPrint
        if @state == 1
            print "* "
        elsif @state == 3
            print "P "    
        elsif @state == 2
            print "#{@num} "        
        end
    end
end