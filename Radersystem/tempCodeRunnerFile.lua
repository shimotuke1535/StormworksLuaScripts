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