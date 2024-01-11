class Thing
    def initialize()
        base_garden, @garden = File.open("./inputs/21.txt").readlines().map{|x|x.strip().split(//)}, []
        @center = (7*base_garden.length())/2
        for i in 0..7   #1x1 graph => 1x7 graph
            for i in 0..base_garden.length()-1
                @garden.push(base_garden[i])
            end
        end
        for i in 0..@garden.length()-1  #1x7 graph => 7x7 graph
            @garden[i] = @garden[i]*7
        end
    end

    def run(step_limit)
        visited = Array.new(@garden.length()){|i| Array.new(@garden[0].length()) {|j| 999}} #visited[i][j] = min steps required to reach
        queue = [[0,[@center,@center]]] #[current_step, [y,x]]
        visited[@center][@center] = 0
        xdir, ydir = [1,0,-1,0], [0,1,0,-1]
        while not queue.empty?
            s = queue.pop()
            step = s[0]
            s = s[1]
            for i in 0..3
                if @garden[s[0]+ydir[i]][s[1]+xdir[i]] != "#" and step+1 < visited[s[0]+ydir[i]][s[1]+xdir[i]] and step < step_limit
                    queue.push([step+1,[s[0]+ydir[i],s[1]+xdir[i]]])
                    visited[s[0]+ydir[i]][s[1]+xdir[i]] = step+1
                end
            end
        end
        return visited
    end
end

thing = Thing.new()
visited = thing.run(65+(131*2))
puts "Part 1: #{visited.flatten.count{|val| val <= 64 and val % 2 == 0}}"
x, y, z = [0,1,2], [], 202300
for i in 0..2
    y.push(visited.flatten.count{|val| val <= 65+(131*i) and val % 2 == (i+1)%2})
end
puts "Part 2: #{((z-x[1]) * (z-x[2])) / ((x[0]-x[1]) * (x[0]-x[2])) * y[0] + #Lagrange polynomial
((z-x[0]) * (z-x[2])) / ((x[1]-x[0]) * (x[1]-x[2])) * y[1] + 
((z-x[0]) * (z-x[1])) / ((x[2]-x[0]) * (x[2]-x[1])) * y[2]}"