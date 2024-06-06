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
    print("Input Target position x")
    io.write(Target.x)
    print("Input Target position y")
    io.write(Target.y)

    Current = Current.new()
    print("Input Current position x")
    io.write(Current.x)
    print("Input Current position y")
    io.write(Current.y)
    print("Input Current Direction")
    io.write(Current.dir)

    diff = dif.new()
    diff.x = Target.x - Current.x
    diff.y = Target.y - Current.y
    diff.dir = math.atan(diff.y, diff.x) - Current.dir
    print("diff position %f:%f",diff.x,diff.y)
    print("diff direction %f",diff.dir)
    
end
