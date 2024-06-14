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

tick = 0
Target_value = 0.0
--目標位置格納テーブル定義
Target = 
{
    new = function()
        return
        {
            x = 0.0,
            y = 0.0
        }
    end
}
--現在位置・方位格納テーブル定義
Current = 
{
    new = function()
        
        return
        {
            x = 0.0,
            y = 0.0,
            dir = 0.0
        }
    end
}
--差分位置・方位格納テーブル
dif = 
{
    new = function()
        return
        {
            x = 0.0,
            y = 0.0,
            dir = 0.0
        }
    end
}
--PIDコントローラー
function PID_controller(Kp, Ki, Kd, C_value, PreC_value, T)
    Controll_value = 0.0
    e = 0 - C_value
    de = (e - PreC_value) / T
    ie = ie + (e - PreC_value) * T/2
    Controll_value = Kp * e + Ki * ie + Kd * de
    return Controll_value
end
function ontick()
    --変数定義
    distance = 0.0
    pre_distance = 0.0
    direction = 0.0
    pre_direction = 0.0
    throtlle = 0.0
    Ladder = 0.0
    --目標位置取得
    Target = Target.new()
    Target.x = input.getNumber(1)
    Target.y = input.getNumber(2)
    --現在位置・方位取得
    Current = Current.new()
    Current.x = input.getNumber(3)
    Current.y = input.getNumber(4)
    Current.dir = input.getNumber(5)
    --差分位置・方位計算
    diff = dif.new()
    diff.x = Target.x - Current.x
    diff.y = Target.y - Current.y
    diff.dir = math.atan(diff.y, diff.x) - Current.dir
    --PID制御
    throtlle = PID_controller(1, 0, 1, distance, pre_distance, tick)
    Ladder  = PID_controller(1, 0, 1, direction, pre_direction, tick)
    --出力
    output.setNumber(10, throtlle)
    output.setNumber(11, Ladder)
    --tick加算
    tick = tick + 1
end



