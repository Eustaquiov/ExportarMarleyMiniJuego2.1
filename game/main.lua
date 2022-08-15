function love.load()
Object = require "classic"
require "asteroides"
fontJuego = love.graphics.newFont("slkscr.ttf")
marley = {x=350,y=150,sprite,vivo=true}
puntaje=0
tempAsteroide=3
FlechaAr = love.graphics.newImage("assets/FlechaAr.png")
FlechaAb = love.graphics.newImage("assets/FlechaAb.png")
FlechaIz = love.graphics.newImage("assets/FlechaIz.png")
FlechaDe = love.graphics.newImage("assets/FlechaDe.png")
pausa=false
botonPausa = love.graphics.newImage("assets/pausa.png")
sonidoMarleyMuerte = love.audio.newSource("assets/Explosion.wav","static")
sonidoMarihuanaMuerte = love.audio.newSource("assets/cuatroveinteJ.wav","static")
sonidoSeleccion = love.audio.newSource("assets/Seleccion.wav","static")
ejecutando = menuMain
personajes = {love.graphics.newImage("assets/Marley16Bits.png"),love.graphics.newImage("assets/MarleyConGafas.png"),love.graphics.newImage("assets/MarleyDorado.png"),love.graphics.newImage("assets/dientedeleon.png"),love.graphics.newImage("assets/Palta.png"),love.graphics.newImage("assets/lanzaguisantes.png"),love.graphics.newImage("assets/Marihuana16bits.png"),love.graphics.newImage("assets/whatsapp.png"),love.graphics.newImage("assets/Benja.png"),love.graphics.newImage("assets/Plantadetomate.png")}
seleccion = 1
secretito = 0
if love.filesystem.getInfo("maximoPuntaje.txt") == nil then
love.filesystem.write("maximoPuntaje.txt",0)
end
maxPuntaje = love.filesystem.read("maximoPuntaje.txt")
end

function love.update(dt)
ejecutando(dt)
end

function love.draw()
love.graphics.setBackgroundColor(0.2,0.4,0.33)
if ejecutando == menuMain then
menuGraficos()
end
if ejecutando == juegoMain then
juegoGraficos()
end
end

function love.focus(f)
if not f then
pausa = true
end
end

function chequeoColision(x1,y1,x2,y2)
if x1+10 >= x2-9 and x1-10 <= x2+9 and
y1+10 >= y2-9 and y1-10 <= y2+9 then
return true
else
return false
end
end

function juegoMain(dt)
if not pausa then
if marley.vivo then
puntaje = puntaje + 1 * dt
if puntaje >= tempAsteroide then
table.insert(AsteroideOb, AsteroideOb(love.math.random(0,2)))
tempAsteroide = tempAsteroide + love.math.random(2,3)/5
end
end
for i,v in ipairs(AsteroideOb) do
v:update(dt)
if chequeoColision(marley.x,marley.y,v.x,v.y) then
marley.vivo = false
if math.floor(seleccion) == 7 then
love.audio.play(sonidoMarihuanaMuerte)
else
love.audio.play(sonidoMarleyMuerte)
end
if tonumber(maxPuntaje) < puntaje then
love.filesystem.write("maximoPuntaje.txt",math.floor(puntaje))
maxPuntaje = love.filesystem.read("maximoPuntaje.txt")
end
end
if v.y > 180 or v.x > 670 or v.x < 80 or not marley.vivo then
table.remove(AsteroideOb,i)
end
end
end

toques = love.touch.getTouches()
for i, id in ipairs(toques) do
toqueX,toqueY = love.touch.getPosition(id)

if pausa and toqueY > 0 then
pausa = false
end

if toqueY>2 and toqueX>2 and toqueY<18 and toqueX<18 then
pausa = true
end

if toqueY>250 and toqueY<290 then
if toqueX>550 and toqueX<610 and marley.x-10>100 then
marley.x = marley.x - 70 * dt
elseif toqueX>620 and toqueX<680 and marley.x+10<650 then
marley.x = marley.x + 70 * dt
end
end

if toqueX>590 and toqueX<640 then
if toqueY>205 and toqueY<255 and marley.y-10>20 then
marley.y = marley.y - 70 * dt
elseif toqueY>295 and toqueY<345 and marley.y+10<180 then
marley.y = marley.y + 70 * dt
end
end

if not marley.vivo and toqueY>150 and toqueY<170 and 
toqueX>200 and toqueX<400 then
if toqueX>300 then
ejecutando = menuMain
end
marley.x = 350
marley.y = 150
puntaje=0
tempAsteroide=3
marley.vivo = true
end

end

end

function juegoGraficos()
if marley.vivo then
love.graphics.draw(marley.sprite,marley.x,marley.y,0,0.05,0.05,256,256)
love.graphics.draw(FlechaAr,590,205,0,1.25,1)
love.graphics.draw(FlechaAb,590,295,0,1.25,1)
love.graphics.draw(FlechaIz,570,250)
love.graphics.draw(FlechaDe,620,250)
love.graphics.setColor(8/255,24/255,32/255)
love.graphics.line(100,20,650,20,650,180,100,180,100,20)
love.graphics.setColor(1,1,1)
for i,v in ipairs(AsteroideOb) do
v:draw()
end
end

love.graphics.print("Puntaje: "..math.floor(puntaje),fontJuego,200,200)
love.graphics.draw(botonPausa,2,2)

if tonumber(maxPuntaje)<puntaje then
love.graphics.print("Mayor puntaje: "..math.floor(puntaje),fontJuego,200,230)
elseif tonumber(maxPuntaje)>puntaje then
love.graphics.print("Mayor puntaje: "..maxPuntaje,fontJuego,200,230)
end

if not marley.vivo then
love.graphics.print("Perdiste\nVolver a jugar?",fontJuego,200,100)
love.graphics.rectangle("line",200,150,70,20)
love.graphics.print("Reiniciar",fontJuego,201,155)
love.graphics.rectangle("line",280,150,120,20)
love.graphics.print("Volver al menu",fontJuego,281,155)
end

if pausa then
love.graphics.print("En pausa\nToque para reanudar",fontJuego,200,50)
end
end

function menuMain(dt)
toques = love.touch.getTouches()
for i, id in ipairs(toques) do
toqueX,toqueY = love.touch.getPosition(id)
if toqueY>160 and toqueY<200 then
if toqueX>230 and toqueX<270 and seleccion>=2 then
seleccion = seleccion - 10 * dt
love.audio.play(sonidoSeleccion)
elseif toqueX>430 and toqueX<470 and seleccion<=9 then
seleccion = seleccion + 10 * dt
love.audio.play(sonidoSeleccion)
end
end
if toqueX>270 and toqueX<430 and toqueY>230 and toqueY<260 then
if math.floor(seleccion) ~= 2 and math.floor(seleccion) ~= 3 and math.floor(seleccion) ~= 5 and math.floor(seleccion) ~= 6 and math.floor(seleccion) ~= 7 then
marley.sprite = personajes[math.floor(seleccion)]
ejecutando = juegoMain
elseif chequeoDesbloqueo(50,0) and math.floor(seleccion) == 2 then
marley.sprite = personajes[math.floor(seleccion)]
ejecutando = juegoMain
elseif chequeoDesbloqueo(300,0) and math.floor(seleccion) == 3 then
marley.sprite = personajes[math.floor(seleccion)]
ejecutando = juegoMain
elseif chequeoDesbloqueo(20,0) and math.floor(seleccion) == 5 then
marley.sprite = personajes[math.floor(seleccion)]
ejecutando = juegoMain
elseif chequeoDesbloqueo(80,0) and math.floor(seleccion) == 6 then
marley.sprite = personajes[math.floor(seleccion)]
ejecutando = juegoMain
elseif chequeoDesbloqueo(100,0) and math.floor(seleccion) == 7 then
marley.sprite = personajes[math.floor(seleccion)]
ejecutando = juegoMain
end
end
end
end

function menuGraficos()
love.graphics.draw(personajes[math.floor(seleccion)],350,150,0,0.2,0.2,256,256)
love.graphics.draw(FlechaIz,230,160)
love.graphics.draw(FlechaDe,430,160)
love.graphics.rectangle("line",270,230,160,30)
love.graphics.print("Iniciar partida",fontJuego,290,240)

if math.floor(seleccion) == 1 then
love.graphics.print("Marley clasico",fontJuego,320,50)
elseif math.floor(seleccion) == 2  then
love.graphics.print("Marley pero con gafas\n"..chequeoDesbloqueo(50,1),fontJuego,320,50)
elseif math.floor(seleccion) == 3 then
love.graphics.print("Marley dorado\n"..chequeoDesbloqueo(300,1),fontJuego,320,50)
elseif math.floor(seleccion) == 4 then
love.graphics.print("Diente de leon",fontJuego,320,50)
elseif math.floor(seleccion) == 5 then
love.graphics.print("Palta\n"..chequeoDesbloqueo(20,1),fontJuego,320,50)
elseif math.floor(seleccion) == 6 then
love.graphics.print("Lanzaguisantes\n"..chequeoDesbloqueo(80,1),fontJuego,320,50)
elseif math.floor(seleccion) == 7  then
love.graphics.print("Marihuana\n"..chequeoDesbloqueo(100,1),fontJuego,320,50)
elseif math.floor(seleccion) == 8  then
love.graphics.print("Whatsapp",fontJuego,320,50)
elseif math.floor(seleccion) == 9 then
love.graphics.print("Benja Bustos",fontJuego,320,50)
elseif math.floor(seleccion) == 10 then
love.graphics.print("Planta de tomate\nVicky no te enojes   D:",fontJuego,320,50)
end
end

function love.keypressed(key)
if key == "escape" and ejecutando == menuMain then
secretito = secretito + 1
if secretito >= 20 then
seleccion = 10
end
end
end

function chequeoDesbloqueo(puntajeRequerido,retornar)
if retornar==0 then
if tonumber(maxPuntaje) < puntajeRequerido then
return false
else
return true
end
elseif retornar==1 then
if tonumber(maxPuntaje) < puntajeRequerido then
return "Se desbloquea a los "..puntajeRequerido.." puntos"
else
return ""
end
end
end