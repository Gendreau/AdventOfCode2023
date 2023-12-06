lines = File.open("./inputs/3.txt").readlines.map{|x| x.split(/[\n]|([^1234567890])/).reject{|x| x==""}}

class String
    def is_int?
        self.to_i.to_s == self
    end
end

def clear(i, j, num, lines)
    lines[i][j] = '.'
    if j > 0 and lines[i][j-1] == num
        lines[i][j-1] = '.'
    end
    if j > 1 and lines[i][j-2] == num
        lines[i][j-2] = '.'
    end
    if j < lines[i].length()-1 and lines[i][j+1] == num
        lines[i][j+1] = '.'
    end
    if j < lines[i].length()-2 and lines[i][j+2] == num
        lines[i][j+2] = '.'
    end
end


for i in 0..lines.length()-1
    j = 0
    while j < lines[i].length()
        for k in 1..lines[i][j].length()-1
            lines[i].insert(j,lines[i][j])
            j += 1
        end
        j += 1
    end
end

total = 0
total_gear_ratio = 0
adjacencies = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]]
for i in 0..lines.length()-1
    for j in 0..lines[i].length()-1
        gears = []
        if /[^.1234567890]/.match?(lines[i][j])
            for adj in adjacencies
                if not lines[i+adj[0]][j+adj[1]].is_int? 
                    next
                end
                gears.push(lines[i+adj[0]][j+adj[1]])
                total += lines[i+adj[0]][j+adj[1]].to_i
                clear(i+adj[0],j+adj[1],lines[i+adj[0]][j+adj[1]], lines)
            end
            total_gear_ratio += gears[0].to_i*gears[1].to_i if gears.length() == 2
        end
    end
end

puts(total)
puts(total_gear_ratio)