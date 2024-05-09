--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ HOTKEYS ]====]
-- Press F6 to simulate this file
-- Press F7 to build the project, copy the output from /_build/out/ into the game to use
-- Remember to set your Author name etc. in the settings: CTRL+COMMA


--[====[ EDITABLE SIMULATOR CONFIG - *automatically removed from the F7 build output ]====]
---@section __LB_SIMULATOR_ONLY__
do
    ---@type Simulator -- Set properties and screen sizes here - will run once when the script is loaded
    simulator = simulator
    simulator:setScreen(1, "3x3")
    simulator:setProperty("ExampleNumberProperty", 123)

    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(1, screenConnection.isTouched)
        simulator:setInputNumber(1, screenConnection.width)
        simulator:setInputNumber(2, screenConnection.height)
        simulator:setInputNumber(3, screenConnection.touchX)
        simulator:setInputNumber(4, screenConnection.touchY)

        -- NEW! button/slider options from the UI
        simulator:setInputBool(31, simulator:getIsClicked(1))       -- if button 1 is clicked, provide an ON pulse for input.getBool(31)
        simulator:setInputNumber(1, simulator:getSlider(1)*250)        -- set input 1 to the value of slider 1
        simulator:setInputNumber(2, simulator:getSlider(2)/2 - 0.25)

        simulator:setInputBool(32, simulator:getIsToggled(2))       -- make button 2 a toggle, for input.getBool(32)
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

w = 0
h = 0
Point = {
    new = function()
        return
        {
            x = 0,
            y = 0,
        }
    end
};
point = {}
ticks = 0
function onTick()
	x0 = w / 2
	y0 = h - h / 6
    rng = input.getNumber(1)
    dig = math.rad(input.getNumber(2) * 360)
    index = 2.5
    for i = 1, 120, 1
    do
        point[i] = Point.new()
        point[i].x = x0 - (rng/index) * math.sin(dig)
        point[i].y = y0 - (rng/index) * math.cos(dig)
    end 
    Rx = w * math.sin(dig)
    Ry = w * math.cos(dig)
    ticks = ticks + 1
    if ticks == 120 then
        ticks=0
        for i=0 , 120, 1
        do
            point[i].x = 0
            point[i].y = 0
        end
    end
end

function onDraw()
    w = screen.getWidth()
	h = screen.getHeight()
	screen.setColor(0,255,0)
	screen.drawLine(0,y0,w,y0)
	screen.drawLine(x0,0,x0,h)
	screen.drawLine(x0,y0,x0-Rx,y0-Ry)
	for i = 0, 100, 10
	do
		screen.drawCircle(x0,y0,i)
	end
	screen.setColor(255,0,0)
	screen.drawText(x0,y0,point[ticks].x)
	screen.drawText(x0,y0+6,point[ticks].y)
    screen.drawText(x0,y0+12,ticks)
	screen.drawCircleF(point[ticks].x,point[ticks].y,2)
end