patterns = File.open("./inputs/13.txt").read().split("\n\n").map{|x|x.split("\n")}
totalp1, totalp2 = 0, 0

def findReflect(pattern, distance, last=0)
    multi = 100
    for i in 0..1
        for y in 0..pattern.length()-2
            threshold = [y,y+1]
            dist = [threshold[0]+1, pattern.length()-threshold[1]].min
            left = pattern[threshold[0]-dist+1..threshold[0]]
            right = pattern[threshold[1]..threshold[1]+dist-1].reverse
            diffs = 0
            for j in 0..left.length()-1
                for k in 0..left[j].length()-1
                    diffs += left[j][k] == right[j][k] ? 0 : 1
                end
            end
            if diffs == distance and threshold[1]*multi != last
                return threshold[1] * multi
            end
        end
        pattern = pattern.map{|x|x.split(//)}.transpose.map(&:reverse).map{|x|x.join()}
        multi = 1
    end
    return false
end

for pattern in patterns
    res = findReflect(pattern, 0)
    totalp1+=res
    totalp2+=findReflect(pattern,1,res)
end
puts totalp1
puts totalp2