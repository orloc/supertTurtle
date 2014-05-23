os.loadAPI('rom/programs/turtle/SuperTurtle')

local tArgs = { ... }

if #tArgs ~= 3 then 
	print("Usage: fill <width> <height | length> <depth> <wall | floor>")
	return
end

local width = tonumber( tArgs[1] ) 
local height = tonumber( tArgs[2] ) 
--local xPos,zPos,yPos = 0,0,0
local orientation = tostring( tArgs[3] )

orientation = string.lower(orientation);

if orientation ~= 'wall' and orientation ~= 'floor' then
	print("You must pick an orientation! Wall or Floor??")
	return
end

if orientation == 'wall' then 
	orientation = 0
else 
	orientation = 1
end

if  (height * width) < 0 then 
	print("Tunnel dimensions must be positive")
	return 0
end

-- Main ====================

local xCount = 0
local dir = 1
local turn = 0

local myturtle = SuperTurtle.SuperTurtle.create()

term.clear()
term.setCursorPos(1,1)
print('Please put your fill block in slot 16')
sleep(2)
term.clear()

if orientation == 1 then 
	print('Floor Clearing')
	while xCount ~= width do 
		myturtle:fillForward(height-1)
		xCount = xCount + 1
		if xCount ~= width then 
			myturtle:turn(dir)
			if dir == 1 then 
				myturtle:spin(1)
			else 
				turtle.turnLeft()
			end
			myturtle:place()
			if dir == 1 then 
			turtle.turnLeft()
			else 
				turtle.turnRight()
			end
		end
		dir = myturtle:flipDir(dir)
	end
	turtle.up()
	myturtle:placeDown()
end

if orientation == 0 then 
	print('Wall Clearing')
	while xCount ~= width do 
		myturtle:fillUp(height-1)	
		xCount = xCount + 1

		if xCount ~= width then 
			turtle.turnRight()
			myturtle:tryForwards(1)
			myturtle:spin(2)
			myturtle:place()
		end

		myturtle:fillDown(height - 1)	
		xCount = xCount + 1

		if xCount ~= width then 
			myturtle:spin(2)
			myturtle:tryForwards(1)
			myturtle:spin(2)
			myturtle:place()
			myturtle:spin(1)
		end
	end
	turtle.turnLeft()
	myturtle:tryForwards()
	myturtle:spin(2)
	myturtle:place()
end
