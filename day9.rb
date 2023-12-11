history = File.open("./inputs/9.txt").readlines().map{|x| x.split(" ").map{|y|y.to_i}}

def reduce(seq, backwards)
    new_seq = []
    for i in 1..seq.length()-1
        new_seq.push(seq[i]-seq[i-1])
    end
    if new_seq.any?{|x|x!=0}
        if backwards
            seq.unshift(seq[0] - reduce(new_seq, true))
        else
            seq.push(seq[-1] + reduce(new_seq, false))
        end
    end
    return backwards ? seq[0] : seq[-1]
end

puts history.map{|x|reduce(x.clone, false)}.sum
puts history.map{|x|reduce(x.clone, true)}.sum