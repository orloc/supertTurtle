os.loadAPI('rom/programs/turtle/SuperTurtle')

local tArgs = { ... }

if #tArgs ~= 4 then 
	print("Usage: tunnel <width> <height> <depth> <dir>")
	return
end

local xIn = tonumber( tArgs[1] ) 
local yIn = tonumber( tArgs[2] ) 
local zIn = tonumber( tArgs[3] ) 
--local xPos,zPos,yPos = 0,0,0
local digDir = tostring( tArgs[4] )

digDir = string.lower(digDir);

if digDir ~= 'l' and digDir ~= 'r' then
	print("Direction must be L or R")
	return
end

if digDir == 'l' then 
	digDir = 0
else 
	digDir = 1
end

if  (xIn * yIn * zIn) < 0 then 
	print("Tunnel dimensions must be positive")
	return 0
end

local desiredArea = (xIn * yIn * zIn)
local targetArea = 0

-- Main ====================

local xCount = 0
local yCount = 0

local turtle = SuperTurtle.SuperTurtle.create()

while yCount ~= yIn do 	
	while xCount ~= xIn do 

		turtle:lineForward(zIn-1)
		targetArea = targetArea + (zIn-1)
		xCount = xCount + 1
		
		if xCount ~= xIn  then 
			turtle:turn(digDir)
			targetArea = targetArea + 1
		end

		digDir = turtle:flipDir(digDir)
	end
	turtle:spin(2)

	xCount = 0 

	yCount = yCount + 1
	digDir = turtle:flipDir(digDir)
	if yCount ~= yIn then 
		turtle:lineUp(1)
		targetArea = targetArea + 1
	end
end

