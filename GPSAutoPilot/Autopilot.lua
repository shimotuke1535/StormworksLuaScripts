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

function main()
    Target = Target.new()
    io.write(Target.x)
    io.write(Target.y)

    Current = Current.new()
    io.write(Current.x)
    io.write(Current.y)
    io.write(Current.dir)

    diff = dif.new()
    diff.x = Target.x - Current.x
    diff.y = Target.y - Current.y
    diff.dir = math.atan(diff.y, diff.x) - Current.dir
    
end
