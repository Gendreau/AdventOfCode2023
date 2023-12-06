lines = File.open("./inputs/1.txt").readlines.map{|x| x.strip()}
p1sum, p2sum = 0, 0
for line in lines
    if (line =~ /\d/)
        p1sum += (line[line.index(/\d/)] + line[line.rindex(/\d/)]).to_i
    end
end
puts(p1sum)

textNums = ["one","two","three","four","five","six","seven","eight","nine"]
for line in lines
    frontText, backText = [999,0], [0,0]
    for num in textNums
        if not line.include?(num)
            next
        end
        if line.index(num) < frontText[0]
            frontText = [line.index(num),textNums.find_index(num)+1]
        end
        if line.rindex(num) > backText[0]
            backText = [line.rindex(num),textNums.find_index(num)+1]
        end
    end
    if (not line =~ /\d/)
        firstDigit = frontText[1].to_s
        secondDigit = backText[1].to_s
    else
        firstDigit = line.index(/\d/) < frontText[0] ? line[line.index(/\d/)] : frontText[1].to_s
        secondDigit = line.rindex(/\d/) >= backText[0] ? line[line.rindex(/\d/)] : backText[1].to_s
    end
    p2sum += (firstDigit+secondDigit).to_i
end

puts(p2sum)