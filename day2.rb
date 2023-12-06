lines = File.open("./inputs/2.txt").readlines.map{|x| x.split(/[ :,;\n]+|Game/).reject{|x| x==""}}
rgbs = {"red" => 12, "green" => 13, "blue" => 14}
poss, imposs = lines.sum{|x| x[0].to_i}, []
total_pow = 0
for line in lines
    rgb_max = {"red" => 0, "green" => 0, "blue" => 0}
    for i in 0..line.length()
        if not rgbs.key?(line[i])
            next
        end
        if line[i-1].to_i > rgb_max[line[i]]
            rgb_max[line[i]] = line[i-1].to_i
        end
        if line[i-1].to_i > rgbs[line[i]]
            imposs.push(line[0].to_i)
        end
    end
    total_pow += rgb_max["red"] * rgb_max["green"] * rgb_max["blue"]
end
puts(poss-imposs.uniq.sum)
puts(total_pow)