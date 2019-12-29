module UX
    def setCoordinates(modeName)
        puts "Select coordinates - #{modeName} mode"
        puts "X: "
        x = gets.to_i
        puts "Y: "
        y = gets.to_i
        return [x,y]
    end
    
    def setDifficulty
        #clear console
        system "cls"

        #set max level
        maxLevel = 3

        #level categories
        #1 - 5 x 5 - 5 mines
        #2 - 10 x 10 - 35 mines
        #3 - 20 x 20 - 100 min

        puts "\nChoose your level\n-------------------------\n 1-easy(5x5 - 10mines)\n 2-medium(10x10 - 35mines)\n 3-hard(20x20 - 100mines)\n"
        puts "-------------------------\nLevel: "
        difficulty = gets.to_i

        if difficulty == 0 || !difficulty.is_a?(Numeric) || difficulty > maxLevel
            puts "Please, set a NUMBER higher than 0 and lower or equal than #{maxLevel}\nHit enter if you understand"
            decission = gets.chomp
            self.setDifficulty
        else
            puts "\nAre you sure you want to set your LEVEL to #{difficulty}\nY or N"
            decission = gets.chomp
            if decission == "N" || decission == "n"
                self.setDifficulty
            else
                return difficulty
            end
        end

    end
end