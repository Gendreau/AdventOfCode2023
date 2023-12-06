lines = File.open("./inputs/5.txt").read().split(/\n\n/)
seeds = lines[0].split(/[ ]|seeds:/).reject{|x| x==""}.map{|x|x.to_i}
tables = []
for table in lines[1..]
    tables.push(table.split(/\n/)[1..].map{|x| x.split(/ /).map(&:to_i)})
end

def evaluateSeeds(seeds, tables)
    locations = []
    for seed in seeds
        for table in tables
            for line in table
                if (line[1]..line[1]+line[2]-1) === seed
                    seed = line[0]+(seed-line[1])
                    break
                end
            end
        end
        locations.push(seed)
    end
    return locations
end

def evaluateLocs(seeds, tables)
    location = -1
    loop do
        location += 1
        finalSeed = location
        for table in tables.reverse()
            for line in table
                if (line[0]..line[0]+line[2]-1) === finalSeed
                    finalSeed = line[1]+(finalSeed-line[0])
                    break
                end
            end
        end
        break if isInSeedRange(finalSeed, seeds)
    end
    return location
end


def isInSeedRange(num, seeds)
    for seed in seeds
        if num >= seed[0] and num < seed[0]+seed[1]
            return true
        end
    end
    return false
end

seedRanges, i = [], 1
while i < seeds.length()
    seedRanges.push([seeds[i-1],seeds[i]])
    i+=2
end

puts evaluateSeeds(seeds, tables).min()
puts evaluateLocs(seedRanges, tables)