module RD
    def generateBombs(fields, maxBombs, size, notX, notY)
        planted = 0
        x = 0
        y = 0
        # siblingsX = [-1,0,+1,+1,+1,0,-1,-1]
        # siblingsY = [-1,-1,-1,0,+1,+1,+1,0]

        while planted < maxBombs
            for i in fields
                bomb = rand(0..1)
                
                #put bombs only if ...
                if x != notX && y != notY && x != notX -1 && y != notY-1 && x != notX && y != notY-1 && x != notX +1 && y != notY-1 && x != notX +1 && y != notY && x != notX +1 && y != notY+1 && x != notX && y != notY+1 && x != notX -1 && y != notY+1 && x != notX -1 && y != notY
                    fields[[x,y]].state = bomb
                        if bomb == 1
                            planted += 1
                        else
                    end
                end
               
                #first do columns
                x += 1
                if x > size[0]
                    #then next row
                    if y == size[1]
                        break
                    end
                    x = 0
                    y += 1
                end
            end
            x = 0
            y = 0
        end
    end
end