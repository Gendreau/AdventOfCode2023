lines = File.open("./inputs/7.txt").readlines().map{|x| [x[0..4],x[6..].to_i]}

def findHand(hand)
    case(hand.split(//).uniq.length())
    when 1
        return 6
    when 2
        return hand.chars.uniq.count{|char| hand.count(char) == 4} == 1 ? 5 : 4
    when 3
        return hand.chars.uniq.count{|char| hand.count(char) == 3} == 1 ? 3 : 2
    when 4
        return 1
    when 5
        return 0
    end
end

def findHandWithJokers(hand)
    jokers = hand.count('J')
    if jokers == 0
        return findHand(hand)
    end
    case(hand.split(//).uniq.length())
    when 1..2
        return 6
    when 2
        return 6
    when 3
        if hand.chars.uniq.count{|char| hand.count(char) == 3} == 1 or jokers > 1
            return 5
        else
            return 4
        end
    when 4
        return 3
    when 5
        return 1
    end
end  

def normalize(hand, joker)
    return hand.gsub(/[AKQJT]/, 'A'=>'Z', 'K'=>'Y', 'Q'=>'X', 'J'=>joker, 'T'=>'V')
end

sorted = lines.sort_by{|x| [findHand(x[0]),normalize(x[0],'W')]}
score = sorted.map{|x| (sorted.index(x)+1) * x[1]}.sum
puts score

sorted = lines.sort_by{|x| [findHandWithJokers(x[0]), normalize(x[0],'1')]}
score = sorted.map{|x| (sorted.index(x)+1) * x[1]}.sum
puts score