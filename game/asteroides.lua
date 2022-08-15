AsteroideImagen = love.graphics.newImage("assets/Asteroide.png")
AsteroideOb = Object:extend()

function AsteroideOb:new(w)
self.b = w
if w == 0 then
self.x = love.math.random(101,649)
self.y = -10
elseif w == 1 then
self.x = 80
self.y = love.math.random(21,179)
elseif w == 2 then
self.x = 670
self.y = love.math.random(21,179)
end

end

function AsteroideOb:update(dt)
if self.b == 0 then
self.y = self.y + 50 * dt
elseif self.b == 1 then
self.x = self.x + 50 * dt
elseif self.b == 2 then
self.x = self.x - 50 * dt
end
end

function AsteroideOb:draw()
love.graphics.draw(AsteroideImagen,self.x,self.y,0,0.1,0.1,128,128)
end