function love.load()
    math.randomseed(os.time())

    anim8 = require 'anim8'
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5)

    susImage = love.graphics.newImage('sheeeeesh.png')
    dripImage = love.graphics.newImage('drip.jpg')
    sussyImage = love.graphics.newImage('damn.png')

    local susG = anim8.newGrid(100, 100, susImage:getWidth(), susImage:getHeight())
    susAnim = anim8.newAnimation(susG('1-2',1, '1-2',2), 0.1)

    vineBoomSound = love.audio.newSource('vine-boom.mp3', 'static')
    amongusSound = love.audio.newSource('AMONGUS.mp3', 'static')

    cmates = {}
    ss = 200

    for i=0, 1000 do
        newSus(math.random(0, 1920),
               math.random(0, 1080),
               math.random(0, 2*math.pi))
    end
end

function love.update(dt)
    susAnim:update(dt)

    for i, sus in ipairs(cmates) do
        sus.x = sus.x + math.random(-ss, ss) * dt
        sus.y = sus.y + math.random(-ss, ss) * dt
        sus.r = sus.r + sus.rv * dt
    end

    local rand = math.random(1, 150)
    if rand == 1 then
        vineBoomSound:play()
    end
    if rand == 2 then
        amongusSound:play()
    end
end

function love.draw()
    love.graphics.draw(dripImage, 0, 0, 0, love.graphics.getWidth()/1280, love.graphics.getHeight()/720)
    for i, sus in ipairs(cmates) do
        if sus.isSus then
            love.graphics.draw(sussyImage, sus.x, sus.y, sus.r, 1, 1, 50, 50)
        else
            susAnim:draw(susImage, sus.x, sus.y, sus.r, 1, 1, 50, 50)
        end
    end
end

function newSus(x, y, r)
    local sus = {}
    sus.x = x
    sus.y = y
    sus.r = r
    sus.rv = math.random(-3, 3)
    sus.isSus = false

    table.insert(cmates, sus)
end

function love.mousepressed(x, y, button, istouch, presses)
    for i, sus in ipairs(cmates) do
        if distance(x, y, sus.x, sus.y) < 30 then
            sus.isSus = true
        end
    end
end

function distance(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end