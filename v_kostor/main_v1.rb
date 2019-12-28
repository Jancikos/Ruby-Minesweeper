require_relative "hracia_mapa"

include Hracia_mapa

system("clear")


## declarate flags
#blank = 0
#mine = 1
#tested = 2
#opened = 3
## declarate variables
$x_count = 10 #riadky
$y_count = 25 # stlpce
$mine_count = 100
$mine_map = Array.new
$b_mine_mode = true
#

def generate_map(input)
    x = input[0].to_i
    y = input[1].to_i

    # nainicializuj prazdnu mapu
    for i in (0...$x_count * $y_count)
        id = i
        x_position = i / $y_count 
        y_position = i.modulo($y_count)
        $mine_map.push(id:i, state:0, surrounding_mines:0, x_position: x_position, y_position: y_position, flag: false)
        # $flag_map.push(id:i, state: false, x_position: x_position, y_position: y_position)
    end
    #

    #vloz miny do mapy
    lastIndex = 0
     for i in (0...$mine_count)
        block = $mine_map[get_index_from_coordinates(x,y)]
        index = rand(0...$mine_map.length)

        x_position = $mine_map[index][:id].to_i / $y_count 
        y_position = $mine_map[index][:id].modulo($y_count)

        # draw_map(true)
        # gets 

        if ($mine_map[index][:state] == 0)
           if sum_surrounding_mines(block) == 0
            $mine_map[index][:state] = 1
            lastIndex = index
           else
            $mine_map[lastIndex][:state] = 0
            redo
           end
        else
           redo
        end

        # if ($mine_map[index][:state] == 0 && (x -x_position).abs > 1 && (y -y_position).abs > 1)
        #    $mine_map[index][:state] = 1
        # else
        #     redo
        # end
    end

    #vypocitaj okolite miny
    $mine_map.each do |block|
        block[:surrounding_mines] = sum_surrounding_mines(block)
    end

    rerender_map(x,y)
end

def sum_surrounding_mines (block)
    mine_count = 0
    # puts "Mina:#{index} ma suradnice x:#{x_position} a y:#{y_position}"
    
    for x in (-1..1)
        for y in (-1..1)
            checking_x = block[:x_position].to_i + x.to_i
            checking_y = block[:y_position].to_i + y

            # puts checking_x
            if !out_of_bounds(checking_x, checking_y)
                next_index = get_index_from_coordinates(checking_x, checking_y)
                if($mine_map[next_index][:state] == 1)
                    mine_count += 1
                end
            end
        end
    end


    return mine_count
end
def out_of_bounds(x, y)
    if(x < 0 || y < 0)
        return true
    end
    if(x >= $x_count || y>= $y_count)
        return true
    end
    
    return false
end
def get_index_from_coordinates(x, y)
    navratova_hodnota = 0
    if !out_of_bounds(x,y)
        $mine_map.each do |block|
            if(block[:x_position] == x && block[:y_position] == y)
                navratova_hodnota = block[:id].to_i
            end
        end
    else
        puts "Mal som returnut nil"
    end

    navratova_hodnota
end

def draw_map (mine_visility=false)
    index = 0

    print "\t\t\t"
    if  $b_mine_mode
        puts "MINE mode"
    else
        puts "FLAG mode"
    end

    ## y nav bar
    print "   "
    for stlpec in (0...$y_count / 10)
        for i in (0...10)
            print stlpec.to_s + " "
        end
    end
    for stlpec in (0...$y_count % 10)
        print ($y_count / 10).to_s + " "
    end
    puts ""

    print "   "
    for stlpec in (0...$y_count / 10)
        for i in (0...10)
            print i.to_s + " "
        end
    end
    for stlpec in (0...$y_count % 10)
        print stlpec.to_s + " "
    end
    puts ""
    puts ""
    ##

    for riadok in (0...$x_count)
        ## x nav bar
        if riadok < 10
            print riadok.to_s + "  "
        else
            print riadok.to_s + " "
        end
        ## 
        for stlpec in (0...$y_count)
            char = ""
            case $mine_map[index][:state]
                when 1 
                    if mine_visility
                        char = "M"
                    else
                        char ="*"
                    end
                when 2
                    char = "*"
                when 3
                    char = $mine_map[index][:surrounding_mines]
                else
                    char = "*"
            end
            if($mine_map[index][:flag].to_s == "true")
                char = "F"
            end
            print char.to_s + " "
            index += 1
        end
        puts ""
    end
end

def hra 
    while true 
        input = get_player_input

        if(input.join == "")
            ##switch mode
            $b_mine_mode = !$b_mine_mode
            system("clear")
            draw_map
        else   
            x = input[0].to_i
            y = input[1].to_i

            if $b_mine_mode
                ## mine_mode 
                if mine_hit(x, y)
                    $mine_map[get_index_from_coordinates(x,y)][:state] = 2
                    draw_map
                    puts "Trafil si minu"
                    break
                else
                    rerender_map(x, y)
                end
            else
                ## flag mode
                flag_block = $mine_map[get_index_from_coordinates(x,y)]
                flag_block[:flag] = !flag_block[:flag]
            end

            if game_continue
                system("clear")
                # draw_map(true)
                draw_map
            else
                puts "Vyhral si!"
                draw_map true
                break;
            end
        end       
    end
end 

def game_continue
    $mine_map.each do |block|
        # puts block
        if block[:state] == 0
            return true
        end
    end
    
    false
end
def get_player_input
    input = Array.new

    print "Zadajte riadok: "
    input.push(gets.chomp)

    print "Zadajte stlpec: "
    input.push(gets.chomp)

    puts input
    input
end
def open__surrendings(x,y)
    actual_block = $mine_map[get_index_from_coordinates(x,y)]

    if actual_block[:state] == 3 || actual_block[:flag]
        return
    else
        actual_block[:state] = 3
        for x in (-1..1)
            for y in (-1..1)
                checking_x = actual_block[:x_position].to_i + x.to_i
                checking_y = actual_block[:y_position].to_i + y

                if !out_of_bounds(checking_x, checking_y)
                    if actual_block[:surrounding_mines] == 0
                        open__surrendings(checking_x, checking_y)
                    end
                end
            end
        end
    end
end
def rerender_map (x,y)
    $mine_map[get_index_from_coordinates(x,y)][:state] = 2
    $mine_map[get_index_from_coordinates(x,y)][:flag] = false
    open__surrendings(x,y)
end
def mine_hit (x,y)
    if($mine_map[get_index_from_coordinates(x,y)][:state] == 1)
        return true
    else
        return false
    end
end

## main
generate_map(get_player_input)
draw_map
hra
#