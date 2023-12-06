lines = File.open("./inputs/4.txt").readlines.map{|x| x.split(/[ Card:\n]+/).reject{|x| x==""}}
offset = lines[0].index('|')
total = 0
copies = Array.new(lines.length()){|x|1}
for line in lines
    matches = (line[1..offset-1]&line[offset+1..]).length()
    if matches == 0
        next
    end
    total += 2**(matches-1)
    for i in 1..matches
        copies[line[0].to_i-1+i]+=copies[line[0].to_i-1]
    end
end
puts total
puts copies.sum