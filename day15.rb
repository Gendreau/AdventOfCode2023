seq = File.open("./inputs/15.txt").read().strip().split(",")

def hashf(seq)
    total = 0
    for c in seq.split(//)
        total += c.ord
        total *= 17
        total %= 256
    end
    total
end

puts seq.sum{|x|hashf(x)}

boxes = Array.new(256){|x|[]}

for s in seq
    if s[-1] == "-"
        s = s + "0"
    end
    box_num = hashf(s[0..-3])
    if s[-2] == "-"
        boxes[box_num].reject!{|x|x.start_with?(s[0..-3])}
    elsif s[-2] == "="
        s[-2] = " "
        replaced = false
        for i in 0..boxes[box_num].length()-1
            if boxes[box_num][i].start_with?(s[0..-3])
                boxes[box_num][i] = s
                replaced = true
            end
        end
        if not replaced
            boxes[box_num].push(s)
        end
    end
end

total = 0
for box in boxes
    for lens in box
        total += (1+boxes.index(box))*(1+box.index(lens))*lens[-1].to_i
    end
end
puts total