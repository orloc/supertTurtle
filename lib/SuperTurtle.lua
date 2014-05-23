SuperTurtle = {}
SuperTurtle.__index = SuperTurtle

function SuperTurtle.create()
	local sTurtle = {}
	setmetatable(sTurtle,SuperTurtle)

	sTurtle.fuelSlot = 1
	sTurtle.compareSlot = 16

	return sTurtle
end

function SuperTurtle:refuel( amount ) 
	local fuelLevel = turtle.getFuelLevel()
	if fuelLevel == "unlimited" then
		return true
	end

	if fuelLevel < amount then 
		local fueled = false
		for n=1,16 do
			if turtle.getItemCount(n) > 0 then 
				turtle.select(n)
				if turtle.refuel(1) then 
					while turtle.getItemCount(n) > 0 and turtle.getFuelLevel() < amount do 
						turtle.refuel(1)
					end
					if turtle.getFuelLevel() >= amount then 
						turtle.select(1)
						return true
					end
				end
			end
		end
		turtle.select(1)
		return false
	end
	return true
end

function SuperTurtle:checkFuel(fuel) 
	while not self:refuel(fuel) do 
		print( "Not enough fuel." )
		sleep(2.5)
	end
end

function SuperTurtle:tryForwards(fuel) 
	self:checkFuel(fuel)
	
	local moved = false

	while moved ~= true do 
		if turtle.detect() then 
			while turtle.detect() do 
				turtle.dig()
			end
		else 
			while turtle.attack() do 
				sleep(0.5)
			end
		end
		

		if turtle.forward() then 
			moved = true
		end
	end
	return true
end

function SuperTurtle:tryUp(fuel) 
	self:checkFuel(fuel)	

	local moved = false

	while moved ~= true do 
		if turtle.detectUp() then 
			while turtle.detectUp() do 
				turtle.digUp()
			end
		else 
			while turtle.attackUp() do 
				sleep(0.5)
			end
		end

		if turtle.up() then 
			moved = true
		end
	end
	return true
end

function SuperTurtle:tryDown(fuel) 
	self:checkFuel(fuel)	

	local moved = false

	while moved ~= true do 
		if turtle.detectDown() then 
			while turtle.detectDown() do 
				turtle.digDown()
			end
		else 
			while turtle.attackDown() do 
				sleep(0.5)
			end
		end

		if turtle.down() then 
			moved = true
		end
	end
	return true
end

function SuperTurtle:turn(dir) 
	self:checkFuel(1)

	if dir == 0 then 
		if turtle.turnLeft() then
			self:tryForwards(1)	
			if turtle.turnLeft() then 
				return true;
			end
			return false;
		end
		return false;
	else 
		if turtle.turnRight() then
			self:tryForwards(1)	
			if turtle.turnRight() then 
				return true;
			end
			return false;
		end
		return false;
	end
end

function SuperTurtle:spin(times)
	for i=1, times do 
		turtle.turnRight()
	end
end

function SuperTurtle:lineForward(length)
	local moved = 0
	
	while moved ~= length do 
		self:tryForwards(length)		
		moved = moved + 1 
	end

end

function SuperTurtle:lineUp(length)
	local moved = 0

	while moved ~= length do 
		self:tryUp(length)		
		moved = moved + 1 
	end
end

function SuperTurtle:flipDir(digDir)
	local dir

	if digDir == 1 then 
		dir = 0
	else 
		dir = 1
	end

	return dir
end

function SuperTurtle:findBlock()
	for slot = 1, 15 do 
		turtle.select(slot)
		if turtle.compareTo(self.compareSlot) then 
			return true
		end
	end
	return false
end

function SuperTurtle:place()
	local placed = false
	
	while not self:findBlock() do 
		print('Add more blocks')
		sleep(2)
	end
	
	while not placed do 
		if turtle.place() then 
			placed = true
		end
	end
end

function SuperTurtle:placeDown()
	local placed = false
	
	while not self:findBlock() do 
		print('Add more blocks')
		sleep(2)
	end
	while not placed do 
		if turtle.placeDown() then 
			placed = true
		end
	end
end
function SuperTurtle:placeUp()
	local placed = false
	
	while not self:findBlock() do 
		print('Add more blocks')
		sleep(2)
	end
	while not placed do 
		if turtle.placeUp() then 
			placed = true
		end
	end
end

		
function SuperTurtle:putBlockBehind()
	self:spin(2)	
	self:place()
	self:spin(2)
end
		

function SuperTurtle:fillForward(length)
	local moved = 0

	while moved ~= length do
		if self:tryForwards(1) then
			self:putBlockBehind()
			moved = moved + 1
		end
	end
end

function SuperTurtle:fillUp(length)
	local moved = 0

	while moved ~= length do 
		if self:tryUp(1) then 
			self:placeDown()
			moved = moved + 1
		end
	end
end


