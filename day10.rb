maze = File.open("./inputs/10.txt").readlines().map{|x|x.strip().split(//)}

#Find origin
for y in 0..maze.length()-1
    for x in 0..maze[y].length()-1
        if maze[y][x] == "S"
            src = [y,x]
        end
    end
end

xs, ys = [src[1]], [src[0]]

#Find first pipe after origin
if ["|", "7", "F"].include?(maze[src[0]-1][src[1]]) #UP
    src = [src[0]-1,src[1],"D"]
elsif ["-", "L", "F"].include?(maze[src[0]][src[1]-1]) #LEFT
    src = [src[0],src[1]-1,"R"]
elsif ["-", "J", "7"].include?(maze[src[0]][src[1]+1]) #RIGHT
    src = [src[0],src[1]+1,"L"]
elsif ["|", "L", "J"].include?(maze[src[0]+1][src[1]]) #DOWN
    src = [src[0]+1,src[1],"U"]
end

pipes = {"|"=>["U","D"], "-"=>["L","R"], "L"=>["U","R"], "J"=>["L","U"], "7"=>["L","D"], "F"=>["R","D"]}
length = 1
curr = maze[src[0]][src[1]]

# Find length of loop and coordinates of each vertex
while not curr == "S"
    xs.push(src[1])
    ys.push(src[0])
    next_dir = pipes[curr][0] == src[2] ? pipes[curr][1] : pipes[curr][0]
    case next_dir
    when "U"
        src = [src[0]-1,src[1],"D"]
    when "L"
        src = [src[0],src[1]-1,"R"]
    when "R"
        src = [src[0],src[1]+1,"L"]
    when "D"
        src = [src[0]+1,src[1],"U"]
    end
    length += 1
    curr = maze[src[0]][src[1]]
end

#Shoelace Algorithm
x_sum = xs[-1]*ys[0]
y_sum = ys[-1]*xs[0]
for i in 1..ys.length()-1
    x_sum += xs[i-1]*ys[i]
    y_sum += ys[i-1]*xs[i]
end

#Pick's Theorem
area = (x_sum-y_sum).abs/2
enclosed_area = area-(length/2)+1

puts length/2
puts enclosed_area