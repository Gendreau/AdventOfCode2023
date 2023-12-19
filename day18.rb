instructions = File.open("./inputs/18.txt").readlines().map{|x|x.strip().split(/[ ()#]+/)}

def process(instructions)
    xs, ys = [0],[0]
    x_curr, y_curr = 0, 0
    for instruction in instructions
        case instruction[0]
        when "U"
            y_curr += instruction[1].to_i
        when "R"
            x_curr += instruction[1].to_i
        when "L"
            x_curr -= instruction[1].to_i
        when "D"
            y_curr -= instruction[1].to_i
        end
        xs.push(x_curr)
        ys.push(y_curr)
    end
    perimeter = instructions.sum{|x|x[1].to_i}
    x_sum = xs[-1]*ys[0]
    y_sum = ys[-1]*xs[0]
    for i in 1..ys.length()-1
        x_sum += xs[i-1]*ys[i]
        y_sum += ys[i-1]*xs[i]
    end
    area = (x_sum-y_sum).abs/2
    return perimeter+area-(perimeter/2)+1
end

new_instructions = []
dirmap = {"0"=>"R","1"=>"D","2"=>"L","3"=>"U"}
for instruction in instructions
    new_instructions.push([dirmap[instruction[2][-1]],instruction[2][..-2].to_i(16)])
end
puts process(instructions)
puts process(new_instructions)