lines = File.open("./inputs/24.txt").readlines.map{|x| x.split(/[,@ ]+/).map{|y|y.to_f}}
lines = lines.map{|x|[x[0..2],x[3..]]}
$combos = lines.combination(2).to_a

def getInfoFromCombo(combo, x=0,y=0)
    vx1, vx2 = combo[0][1][0]-x, combo[1][1][0]-x
    vy1, vy2 = combo[0][1][1]-y, combo[1][1][1]-y
    x1, y1, m1 = combo[0][0][0], combo[0][0][1], vy1/vx1
    x2, y2, m2 = combo[1][0][0], combo[1][0][1], vy2/vx2
    return [x1,y1,m1,x2,y2,m2,vx1,vx2,vy1,vy2]
end

def findIntersection(x1,y1,m1,x2,y2,m2)
    b1 = m1*x1*(-1)+y1
    b2 = m2*x2*(-1)+y2
    x = (b2-b1)/(m1-m2)
    y = (m1*b2-m2*b1)/(m1-m2)
    return [x,y]
end

def countIntersections()
    # range = (7..27)
    range = (200000000000000..400000000000000)
    total = 0
    for combo in $combos
        i = getInfoFromCombo(combo)
        x1,y1,m1,x2,y2,m2,vx1,vx2,vy1,vy2 = i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7],i[8],i[9]
        if m1 == m2
            next
        end
        intersection = findIntersection(x1,y1,m1,x2,y2,m2)
        vx1C, vx2C, vy1C, vy2C = vx1 > 0, vx2 > 0, vy1 > 0, vy2 > 0
        i01C, i02C, i11C, i12C = intersection[0] < x1, intersection[0] < x2, intersection[1] < y1, intersection[1] < y2
        if not(vx1C^i01C) or not(vx2C^i02C) or not(vy1C^i11C) or not(vy2C^i12C)
            next
        elsif range === intersection[0] and range === intersection[1]
            total += 1
        end
    end
    return total
end

def countIntersectionsFaster(x_off,y_off)
    total = 0
    for combo in $combos
        i = getInfoFromCombo(combo,x_off,y_off)
        x1,y1,m1,x2,y2,m2,vx1,vx2,vy1,vy2 = i[0],i[1],i[2],i[3],i[4],i[5],i[6],i[7],i[8],i[9]
        if m1 == m2
            total += 1
            next
        end
        intersection = findIntersection(x1,y1,m1,x2,y2,m2)
        vx1C, vx2C, vy1C, vy2C = vx1 > 0, vx2 > 0, vy1 > 0, vy2 > 0
        i01C, i02C, i11C, i12C = intersection[0] < x1, intersection[0] < x2, intersection[1] < y1, intersection[1] < y2
        if not(vx1C^i01C) or not(vx2C^i02C) or not(vy1C^i11C) or not(vy2C^i12C)
            return total
        else
            total += 1
        end
    end
    return total
end

def findcommonXYvel()
    for x in -350..350
        for y in -350..350
            total = countIntersectionsFaster(x,y)
            if total == $combos.length()
                return [x,y]
            end
        end
    end
end

def findZs(lines, x2, vx2)
    zs = []
    for i in 0..30
        localZs = []
        vx1, vz1 = lines[i][1][0], lines[i][1][2]
        x1, z1 = lines[i][0][0], lines[i][0][2]
        if vx1 != vx2 and x1 != x2
            t = (x2-x1)/(vx1-vx2)
        else
            next
        end
        for zv in -30..30
            zp = t*(vz1-zv)+z1
            if (zp%1).zero?
                localZs.push([zv,zp])
            end
        end
        if zs.empty?
            for z in localZs
                zs.push(z)
            end
        end
        zs = zs&localZs
        break if zs.length()==1
    end
    return zs
end

puts "Intersections: #{countIntersections()}"
cXYvel = findcommonXYvel()
cXYpos = getInfoFromCombo($combos[0],cXYvel[0],cXYvel[1])
cXYpos = findIntersection(cXYpos[0],cXYpos[1],cXYpos[2],cXYpos[3],cXYpos[4],cXYpos[5])
cZs = findZs(lines,cXYpos[0],cXYvel[0])
puts "xpos: #{cXYpos[0].to_i} | ypos: #{cXYpos[1].to_i} | zpos: #{cZs[0][1].to_i}"
puts "xvel: #{cXYvel[0]} | yvel: #{cXYvel[1]} | zvel: #{cZs[0][0]}"
puts "Sum of initial rock pos coords: #{(cXYpos[0] + cXYpos[1] + cZs[0][1]).to_i}"