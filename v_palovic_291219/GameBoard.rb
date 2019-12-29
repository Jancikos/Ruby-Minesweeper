require_relative "Field.rb"

class GameBoard
    attr_accessor :size, :field, :offset
    def initialize(x, y)
        @x = x #columns
        @y = y #rows
        @size = [x, y]
        
        @x_offset = 2;
        @y_offset = 2;
        @offset = [@x_offset, @y_offset]

        #fields - I have to be able to specify, where the field is exactly
        @field = Hash.new

        create()
    end

    private
    def create
        #column nubmers
        columnTensNums = 0
        columnOnesNums = 0
        #row numbers
        rowTensNums = 0
        rowOnesNums = 0
        

        #first line of numbers
        for i in (0..@x + @x_offset)
            if i < @x_offset
                print " "
            elsif i < 10+@x_offset
                print "#{columnTensNums} " #should be 0
            else
                if (i-@x_offset).modulo(10) == 0
                    columnTensNums += 1
                end
                print "#{columnTensNums} "
            end
        end

        #line splitting
        puts 

        #second line of numbers
        for i in (0..@x + @x_offset)
            if i < @x_offset
                print " "
            else
                if (i-@x_offset).modulo(10) == 0
                    columnOnesNums = 0;
                else
                    columnOnesNums += 1
                end
                print "#{columnOnesNums} "
            end
        end
        puts
        
        #rows
        for i in (0..@y)
            if i == 0
                print rowTensNums
                print rowOnesNums
                for j in (0..@x)
                    if j == 0
                        #sets 0 index in @field
                        @field[[0,0]] = Field.new(0,0,0,0)
                    else
                        #sets first row in gameboard
                        @field[[j, 0]] = Field.new(j,0,0,0)
                    end
                end
                puts 
                rowOnesNums = 1
                next
            else
                print rowTensNums
                print rowOnesNums
                for j in (0..@x)
                    #sets others
                    @field[[j, i]] = Field.new(j,i,0,0)
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
end