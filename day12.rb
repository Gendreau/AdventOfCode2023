lines = File.open("./inputs/12.txt").readlines()
$cache = {}

def DP(seq, groups)
    if $cache.key?([seq, groups])
        return $cache[[seq, groups]]
    end
    value = process(seq, groups)
    $cache.store([seq,groups],value)
    return value
end

def process(seq,groups)
    while true
        if groups.empty?
            return seq.include?("#") ? 0 : 1
        end
        if seq.nil? or seq.empty?
            return 0
        end
        case seq[0]
        when "."
            seq = seq[1..]
        when "?"
            return DP(seq[1..],groups) + DP("#" + seq[1..],groups)
        when "#"
            if seq.length() < groups[0] or seq[0..groups[0]-1].include?(".")
                return 0
            end
            if groups.length() > 1
                if (seq.length() < groups[0] or seq[groups[0]] == "#")
                    return 0
                end
                seq = seq[groups[0]+1..]
            else
                seq = seq[groups[0]..]
            end
            groups = groups[1..]
        end
        next
    end
end

totalP1, totalP2 = 0,0
for line in lines
    a, b = line.split(" ")
    b = b.split(",").map{|x|x.to_i}
    totalP1 += DP(a, b)
    totalP2 += DP(a+"?"+a+"?"+a+"?"+a+"?"+a, b+b+b+b+b)
end

puts totalP1
puts totalP2