dish = File.open("./inputs/14.txt").readlines().map{|x|x.strip().split(//)}
p2dish = Marshal.load(Marshal.dump(dish))

def cycleNW(dish, stop=true)
    dirs = [[-1,0],[0,-1]]
    for dir in dirs
        for y in 0..dish.length()-1
            for x in 0..dish.length()-1
                if dish[y][x] == "O"
                    to_move = Marshal.load(Marshal.dump(dir))
                    inc = Marshal.load(Marshal.dump(to_move))
                    while y+to_move[0] >= 0 and y+to_move[0] < dish.length() and x+to_move[1] >= 0 and x+to_move[1] < dish[y].length() and dish[y+to_move[0]][x+to_move[1]] == "."
                        dish[y+to_move[0]][x+to_move[1]] = "O"
                        dish[y+to_move[0]-inc[0]][x+to_move[1]-inc[1]] = "."
                        to_move[0] += inc[0]
                        to_move[1] += inc[1]
                    end
                end
            end
        end
        if stop
            return
        end
    end
end

def cycleSE(dish)
    dirs = [[1,0],[0,1]]
    range = (0..dish.length()-1)
    for dir in dirs
        for y in range.to_a.reverse
            for x in range.to_a.reverse
                if dish[y][x] == "O"
                    to_move = Marshal.load(Marshal.dump(dir))
                    inc = Marshal.load(Marshal.dump(to_move))
                    while y+to_move[0] >= 0 and y+to_move[0] < dish.length() and x+to_move[1] >= 0 and x+to_move[1] < dish[y].length() and dish[y+to_move[0]][x+to_move[1]] == "."
                        dish[y+to_move[0]][x+to_move[1]] = "O"
                        dish[y+to_move[0]-inc[0]][x+to_move[1]-inc[1]] = "."
                        to_move[0] += inc[0]
                        to_move[1] += inc[1]
                    end
                end
            end
        end
    end
end

def cycle(dish)
    cycleNW(dish, false)
    cycleSE(dish)
end

def findLoad(dish)
    load = 0
    for i in 0..dish.length()-1
        load += dish[i].count("O") * (dish.length()-i)
    end
    load
end

cycleNW(dish)
puts findLoad(dish)
dish = p2dish
cache, loads, cycles, first = {}, [], [], 99999
for i in 0..300
    cycle(dish)
    total = findLoad(dish)
    if cache.key?(dish)
        cycles.push(i-cache[dish])
        cache[dish] = i
        first = [first,i].min
    else
        cache.store(dish,i)
    end
    loads.push(total)
end
target = (1000000000-first)%cycles[-1]
puts loads[target+first-1]