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
        simulator:setInputNumber(31, simulator:getSlider(1))        -- set input 31 to the value of slider 1

        simulator:setInputBool(32, simulator:getIsToggled(2))       -- make button 2 a toggle, for input.getBool(32)
        simulator:setInputNumber(32, simulator:getSlider(2) * 50)   -- set input 32 to the value from slider 2 * 50
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

--[[Boggy table making--]]
Boggy = {
    new = function()
        return {
            number = 0,
            Length = 0.00,
            x = 0.00,
            y = 0.00,
            height = 0.00,
            time = 0.00,
            Locked = false,
        };
    end
    
};
function onTick()
    --[[boggy class making--]]
    boggy = {}
	digree = (input.getNumber(32) % (2 * math.pi));
	--Lenlim = property.getNumber(LimitRange);
    Lenlim = 0.5;
    for i = 0, 7, 1 do
        boggy[i] = Boggy.new();  
        boggy[i].number = i;
        boggy[i].Length = input.getNumber(1 + (4 * boggy[i].number)) * math.cos(input.getNumber(3 + (4 * boggy[i].number)));
        boggy[i].x = math.sin(input.getNumber(2 + (4 * boggy[i].number)));
        boggy[i].y = math.cos(input.getNumber(2 + (4 * boggy[i].number)));
        boggy[i].height = input.getNumber(1 + (4 * boggy[i].number)) * math.sin(input.getNumber(3 + (4 * boggy[i].number)));
        boggy[i].time = input.getNumber(4 + (4 * boggy[i].number));
        boggy[i].Locked = input.getBool(1 + (4 * boggy[i].number));      
    end

    RaderReader = {
        x0 = 0.00,
        y0 = 0.00,
        x = 0.00,
        y = 0.00,
    }
end

function onDraw()
    screenheight = screen.getWidth();
    screenwidth = screen.getHeight();

    RaderReader.x0 = screenwidth / 2;
    RaderReader.y0 = screenheight / 2;

    r = screenheight / 2 - 3;
    RaderReader.x = RaderReader.x0 + r * math.sin(digree);
    RaderReader.y = RaderReader.y0 - r * math.cos(digree);

    --[[RaderReader plot]--------------------------------]]
    screen.setColor(0, 255, 0);
    screen.drawCircle(RaderReader.x0, RaderReader.y0, r);
    screen.drawLine(RaderReader.x0, RaderReader.y0, RaderReader.x, RaderReader.y);

    --[[Boggy conntact]----------------------------------]]
    for i = 0, 7, 1 do
        if boggy[i].Locked then
			boggy[i].Length = boggy[i].Length * Lenlim;
			boggy[i].x = (RaderReader.x0 + (boggy[i].Length * math.sin(digree)));
            boggy[i].y = (RaderReader.y0 - (boggy[i].Length * math.cos(digree)));
			screen.setColor(255,0,0);
			for a = 255, 0, -5 do
				screen.setColor(255,0,0,a);
            	screen.drawCircleF(boggy[i].x, boggy[i].y,2);
			end
        end
    end
end