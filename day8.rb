nodes = File.open("./inputs/8.txt").readlines().map{|x| x.split("\n")}
instructions, nodes = nodes[0][0].split('').cycle, nodes[2..].map{|x| x[0].split(/\W+/)}.map{|x| {x[0]=>[x[1],x[2]]}}.inject(&:merge)
instructions2 = instructions.clone
curr, steps = "AAA", 0
while not curr == "ZZZ"
    case instructions.next
    when 'L'
        curr = nodes[curr][0]
    when 'R'
        curr = nodes[curr][1]
    end
    steps += 1
end
puts steps

starts = nodes.keys.select{|x| x[2]=='A'}
ends = nodes.keys.select{|x| x[2]=='Z'}
steps = 0
stops = Array.new(starts.length()){|x|0}

while stops.any?{|x|x==0}
    steps += 1
    case instructions2.next
    when 'L'
        starts = starts.map{|x| nodes[x][0]}
    when 'R'
        starts = starts.map{|x| nodes[x][1]}
    end
    for node in starts
        if node[2]!='Z'
            next
        end
        stops[starts.index(node)] = steps
    end
end

puts stops.reduce(1, :lcm)