space = File.open("./inputs/11.txt").readlines().map{|x|x.strip().split(//)}
galaxies = []


def findBlanks(space)
    blanks = []
    for i in 0..space.length()-1
        if not space[i].include?('#')
            blanks.push(i)
        end
    end
    return blanks
end

$rows = findBlanks(space)
$cols = findBlanks(space.transpose.map(&:reverse))

for y in 0..space.length()-1
    for x in 0..space[y].length()-1
        if space[y][x] == '#'
            galaxies.push([y,x])
        end
    end
end

$combos = galaxies.combination(2).to_a

def findPaths(expansion)
    total_length = 0
    for combo in $combos
        x1, x2, y1, y2 = combo[0][1], combo[1][1], combo[0][0], combo[1][0]
        total_length += (x1-x2).abs + (y1-y2).abs
        x_dist = x1 < x2 ? (x1..x2) : (x2..x1)
        y_dist = y1 < y2 ? (y1..y2) : (y2..y1)
        for blank in $cols
            if x_dist === blank
                total_length += expansion-1
            end
        end
        for blank in $rows
            if y_dist === blank
                total_length += expansion-1
            end
        end
    end
    return total_length
end

puts findPaths(2)
puts findPaths(1000000)