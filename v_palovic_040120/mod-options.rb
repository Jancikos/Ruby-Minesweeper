#loaded options 
#In next version it will be in separated file

module Options
    @level = 0;

    def show
       puts "
Choose your level:
--------------------------
Options:
0 - Easy ( 8x8 - 16 bombs)
1 - EasyMedium (9x9 - 35 bombs)
2 - Medium (11x11 - 40 bombs)
3 - Hard (15x15 - 60 bombs)
4 - Extreme (20x20 - 80 bombs)
6 - Custom (XxY - "'n'" bombs)
-----------------------------
Your selection:
"
    end

    #[x,y,bombs]
    def difficulty
        [{x:8,y:8,bombs:10},{x:9,y:9,bombs:15},{x:11,y:11,bombs:20},{x:15,y:15,bombs:30},{x:20,y:20,bombs:40}]
    end
    
    def offset
        {x_out: 1, x_in: 1, y_out: 1, y_in: 1, coor: 2}
    end

    def chooseOption
        @level = gets.to_i
    end

    def custom
        custom = []

        puts "X:"
        custom[0] = gets.to_i
        puts "Y:"
        custom[1] = gets.to_i
        puts "number of bombs:"
        custom[2] = gets.to_i

        return custom
    end

    attr_accessor :level
end
