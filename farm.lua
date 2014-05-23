width = 4
length = 10
orientation = 0 

-- fuel and slot selection

-- Movment algo
for x=0, width do


    for z=0, length do
        if (turtle.forward()) then
            if (turtle.digDown()) then
                turtle.placeDown()
            end
        end   
    end
    
    if (orientation == 0) then
        if (turtle.turnRight()) then
            turtle.forward()
            turtle.turnRight()
            orientation= orientation + 1
        end
    end  

    if (orientation == 1) then
        if (turtle.turnLeft()) then
            turtle.forward()
            turtle.turnLeft()
            orientation = oirentation - 1
        end
    end
end
        
