function love.load()
Object = require "classic"
require "electrones"
spriteCaja1 = love.graphics.newImage("caja1.png")
spriteCaja2 = love.graphics.newImage("caja2.png")
spriteAfirmativo = love.graphics.newImage("medidorAfirmativo.png")
spriteNegativo = love.graphics.newImage("medidorNegativo.png")
sonidoAfirmativo = love.audio.newSource("afirmativo.wav","static")
posicionDelElectron = 0
cantidadElectrones = 0
chequeo = 0
cajasAbiertas = 0
love.graphics.setBackgroundColor(0.5,0.5,0.5)
end

function love.update(dt)
if love.keyboard.isDown("a") then
    posicionarElectron()
    table.insert(ElectronesC, ElectronesC(posicionDelElectron))
elseif love.keyboard.isDown("b") then
    cantidadElectrones = cantidadElectrones + 1
    table.insert(ElectronesC, ElectronesC(3))
end
end

function love.draw()
love.graphics.print("Electrones lanzados: " .. cantidadElectrones,20,20)
if cajasAbiertas == 0 then love.graphics.print("Cajas cerradas",20,40) else love.graphics.print("Cajas abiertas",20,40) end
love.graphics.draw(spriteCaja1,100,200)
love.graphics.draw(spriteCaja2,100,400)
love.graphics.rectangle("fill",1100,100,100,500)
if chequeo == 1 then
    if posicionDelElectron ~= 1 then 
        love.graphics.draw(spriteNegativo,350,240,0,0.5,0.5)
    else
        love.graphics.draw(spriteAfirmativo,350,240,0,0.5,0.5)
    end
elseif chequeo == 2 then
    if posicionDelElectron ~= 2 then
        love.graphics.draw(spriteNegativo,350,440,0,0.5,0.5)
    else
        love.graphics.draw(spriteAfirmativo,350,440,0,0.5,0.5)
    end
end
for i,v in ipairs(ElectronesC) do
    v:draw()
end
end

function love.keypressed(key)
if key == "v" then
    posicionarElectron()
elseif key == "1" or key == "2" or key == "3" then
    chequeo = tonumber(key)
    if chequeo == posicionDelElectron then
        love.audio.play(sonidoAfirmativo)
    end
elseif key == "0" then
    table.insert(ElectronesC, ElectronesC(posicionDelElectron)) 
end
end

function posicionarElectron()
posicionDelElectron = love.math.random(1,2)
cantidadElectrones = cantidadElectrones + 1
end