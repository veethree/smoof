lg = love.graphics

function love.load()
    smoof = require("smoof")
    love.mouse.setVisible(true)

    large = lg.newFont(64)
    small = lg.newFont(32)

    bg_color = {math.random(), math.random(), math.random()}

    particles = {}
    particle_count = 32
    for i=1, particle_count do
        particles[i] = {
            x = math.random(lg.getWidth()),
            y = math.random(lg.getHeight()),
            rad = math.random(8, 32)
        }
    end
    
    title = {
        text = "Hello World!",
        y = -64,
        r = 0
    }

    sub_title = {
        text = "Smoof!",
        y = -32,
    }

    sub_sub_title = {
        text = "Press space to hide all these",
        y = lg.getHeight(),
    }

    middle_title = {
        text = "This one comes in from the side :O",
        y = (lg.getHeight() / 2),
        x = -lg.getWidth()
    }

    circle = {
        radius = 0,
        alpha = 0
    }

    smoof_mouse = {
        x = 0,
        y = 0
    }

    text_alpha = 1

    test = {1, 2, 3}

    smoof:new(title, {y=32})
    smoof:new(sub_title, {y = 100}, 0.001)
    smoof:new(sub_sub_title, {y = lg.getHeight() - 64})
    smoof:new(middle_title, {x = 0}, 5)

    mouse = {x = 0, y = 0}

    smoof:new(smoof_mouse, mouse, 0.001, nil, true)

    toggle = false
end

function love.update(dt)
    mouse.x, mouse.y = love.mouse.getPosition()
    smoof:update(dt)
    lg.setBackgroundColor(bg_color[1], bg_color[2], bg_color[3])
end

function love.draw()
    for i,v in ipairs(particles) do
        lg.setColor(1, 1, 1, 0.1)
        lg.circle("fill", v.x, v.y, v.rad)

        lg.setColor(1, 1, 1, 0.2)
        lg.circle("line", v.x, v.y, v.rad)
    end

    lg.setColor(1, 1, 1, circle.alpha)
    lg.circle("fill", lg.getWidth() / 2, lg.getHeight() / 2, circle.radius)
    lg.setColor(1, 1, 1, text_alpha)
    lg.setFont(large)
    lg.printf(title.text, 0, title.y, lg.getWidth(), "center", title.r)
    lg.setFont(small)
    lg.printf(sub_title.text, 0, sub_title.y, lg.getWidth(), "center")
    lg.printf(sub_sub_title.text, 0, sub_sub_title.y, lg.getWidth(), "center")
    
    lg.setColor(1-bg_color[1], 1-bg_color[2], 1-bg_color[3], text_alpa)
    lg.printf(middle_title.text, middle_title.x, middle_title.y, lg.getWidth(), "center")

    lg.setColor(1, 1, 1, 1)
    lg.circle("fill", smoof_mouse.x, smoof_mouse.y, 4)
end

function love.keypressed(key)
    if key == "escape" then love.event.push("quit") end
    if key == "space" then
        if toggle then
            smoof:new(title, {y=32})
            smoof:new(sub_title, {y = 100}, 0.001)
            smoof:new(sub_sub_title, {y = lg.getHeight() - 64})
            smoof:new(circle, {radius = 0, alpha = 0},0.00001, 0.1)
            smoof:new(_G, {text_alpha = 1}, 10, 0.01)
            smoof:new(middle_title, {x = 0}, 0.005)
        else
            smoof:new(title, {y=-64})
            smoof:new(sub_title, {y=-64}, 0.001)
            smoof:new(sub_sub_title, {y = lg.getHeight()})
            smoof:new(circle, {radius = lg.getWidth() / 1.5, alpha = 0.5}, 0.00001, 0.1)
            smoof:new(_G, {text_alpha = 0}, 10, 0.01)
            smoof:new(middle_title, {x = -lg.getWidth()}, 0.005)
        end
        toggle = not toggle

        smoof:new(bg_color, {math.random(), math.random(), math.random()}, 0.01, 0.01)

        for i,v in ipairs(particles) do
            smoof:new(v, {x = math.random(lg.getWidth()), y = math.random(lg.getHeight()), rad = math.random(8, 32)}, 0.1)
        end
    end
end

function hsl(h, s, l, a)
	if s<=0 then return l,l,l,a end
	h, s, l = h/256*6, s/255, l/255
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end 
    return (r+m),(g+m),(b+m),a
end