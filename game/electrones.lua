SpriteHuella = love.graphics.newImage("huella.png")
ElectronesC = Object:extend() 

function ElectronesC:new(posElectron)
self.x = love.math.random(1120,1180)
if posElectron == 1 then
self.y = love.math.random(150,250)
elseif posElectron == 2 then
self.y = love.math.random(350,450)
else 
local dispersion = love.math.random(1,5)
    if dispersion == 1 then
        self.y = love.math.random(110,140)
    elseif dispersion == 2 then
        self.y = love.math.random(190,250)
    elseif dispersion == 3 then
        self.y = love.math.random(280,390)
    elseif dispersion == 4 then
        self.y = love.math.random(420,480)
    elseif dispersion == 5 then
        self.y = love.math.random(530,560)
    end
end
end

function ElectronesC:draw()
love.graphics.draw(SpriteHuella,self.x,self.y)
end