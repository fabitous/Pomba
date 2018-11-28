HC = require 'HC'

function love.load ()
  --fundos, placares e variaveis de controle
  fnd=love.graphics.newImage( "image/cityview.jpg" )
  about=love.graphics.newImage( "image/intro.png" )
  presents=love.graphics.newImage( "image/apresenta.png" )
  shit=love.graphics.newImage( "image/shit.jpg" )
  over=love.graphics.newImage( "image/gameover.png" )
  cloud=love.graphics.newImage( "image/cloud2.png" )
  smoke=love.graphics.newImage( "image/smoke2.png" )
  vic=love.graphics.newImage( "image/victory.jpg" )
  cloudMOVE = -30
  aboutTIME = 500 
  presentsTIME = 700
  shitTIME = 1000
  fndMOVE = 0
  timer = 800
  pnts = 0
  HITpnt = 0
  win = false
  on = true
  tm = true
  endCity = false
  playGameMusic = true
  playTactac = true
  playParan = true
  playVictory = true
  playLose = true
  playerSprite = {
	love.graphics.newImage( "image/pombo1.png" ),
	love.graphics.newImage( "image/pombo2.png" ),
	love.graphics.newImage( "image/pombo3.png" ),
	love.graphics.newImage( "image/pombo4.png" ),
	love.graphics.newImage( "image/pombo5.png" ),
	love.graphics.newImage( "image/pombo6.png" ),
	love.graphics.newImage( "image/pombo7.png" ),
	love.graphics.newImage( "image/pombo8.png" ),
	love.graphics.newImage( "image/pombo9.png" )
  }
  spriteCount = 1
  --atributos do jogador
  player = {
  	img=playerSprite[spriteCount],
    x=love.graphics.getWidth()/2,
    y=20,
	carregamento=0
  }
  fires = {}
  firesCirc = {}
  fireCount = 0
  plr = HC.circle(player.x, player.y, 20, 60)
  --gerenciamento das entidades da cidade

function adult()
	return {
		x=20,
		y=80,
		vel=0.2,
		bonus=1,
		shited=love.graphics.newImage( "image/Business_.png" ),
		img=love.graphics.newImage( "image/Business.png" ),
		vida=10,
		major=false,
		adulto=true,
		crianca=false
	}
end
function police() 
	return {
		x=30,
		y=80,
		vel=0.3,
		bonus=2,
		shited=love.graphics.newImage( "image/guarda_.png" ),
		img=love.graphics.newImage( "image/guarda.png" ),
		vida=10,
		major=false,
		adulto=true,
		crianca=false
	}
end
function child() 
	return {
		x=20,
		y=50,
		vel=0.4,
		bonus=3,
		shited=love.graphics.newImage( "image/kid_.png" ),
		img=love.graphics.newImage( "image/kid.png" ),
		vida=10,
		major=false,
		adulto=false,
		crianca=true
	}
end
function build1() 
	return {
		x=140,
		y=320,
		vel=0,
		bonus=0.5,
		shited=love.graphics.newImage( "image/build1_.png" ),
		img=love.graphics.newImage( "image/build1.png" ),
		vida=10,
		major=false,
		adulto=false,
		crianca=false
	}
end
function oldcar() 
	return {
		x=120,
		y=50,
		vel=0.3,
		bonus=0.5,
		shited=love.graphics.newImage( "image/B3_.png" ),
		img=love.graphics.newImage( "image/B3.png" ),
		vida=10,
		major=false,
		adulto=false,
		crianca=false
	}
end
function sportcar() 
	return {
		x=120,
		y=40,
		vel=0.5,
		bonus=2,
		shited=love.graphics.newImage( "image/Chevrolet-2_.png" ),
		img=love.graphics.newImage( "image/Chevrolet-2.png" ),
		vida=10,
		major=false,
		adulto=false,
		crianca=false
	}
end
function comumcar() 
	return {
		x=120,
		y=50,
		vel=0.4,
		bonus=1,
		shited=love.graphics.newImage( "image/fox_.png" ),
		img=love.graphics.newImage( "image/fox.png" ),
		vida=10,
		major=false,
		adulto=false,
		crianca=false
	}
end
function racecar() 
	return {
		x=160,
		y=30,
		vel=3,
		bonus=4,
		shited=love.graphics.newImage( "image/racecar_.png" ),
		img=love.graphics.newImage( "image/racecar.png" ),
		vida=10,
		major=false,
		adulto=false,
		crianca=false
	}
end
function pet() 
	return {
		x=30,
		y=20,
		vel=0.2,
		bonus=2,
		shited=love.graphics.newImage( "image/pet_.png" ),
		img=love.graphics.newImage( "image/pet.png" ),
		vida=10,
		major=false,
		adulto=false,
		crianca=false
	}
end
function trees() 
	return {
		x=100,
		y=80,
		vel=0,
		bonus=0.3,
		shited=love.graphics.newImage( "image/tree_.png" ),
		img=love.graphics.newImage( "image/tree.png" ),
		vida=10,
		major=false,
		adulto=false,
		crianca=false
	}
end
function major() 
	return {
		x=30,
		y=80,
		vel=0.15,
		bonus=0.3,
		shited=love.graphics.newImage( "image/major_.png" ),
		img=love.graphics.newImage( "image/major.png" ),
		vida=60,
		major=true,
		adulto=true,
		crianca=false
	}
end
  --preenhcimento da onda
  citySize = 250
  cities = {}
  for indice = 1,citySize do
	entidade = math.random(10,119)
	if entidade > 9 and entidade < 20 then
		table.insert(cities,adult())
	end
	if entidade > 19 and entidade < 30 then
		table.insert(cities,police())
	end
	if entidade > 29 and entidade < 40 then
		table.insert(cities,child())
	end
	if entidade > 39 and entidade < 50 then
		table.insert(cities,build1())
	end
	if entidade > 49 and entidade < 60 then
		table.insert(cities,oldcar())
	end
	if entidade > 59 and entidade < 70 then
		table.insert(cities,sportcar())
	end
	if entidade > 69 and entidade < 80 then
		table.insert(cities,comumcar())
	end
	if entidade > 79 and entidade < 83 then
		table.insert(cities,racecar())
	end
	if entidade > 82 and entidade < 100 then
		table.insert(cities,pet())
	end
	if entidade > 99 and entidade < 110 then
		table.insert(cities,trees())
	end
	if entidade > 109 and entidade < 120 then
		table.insert(cities,major())
	end
  end
  --posicoes dos elementos da onda
  linepositions = {}
  for onda = 1,citySize do
	position = love.graphics.getWidth() + 50
	for item = 1,onda do
		position = position + cities[item].y
	end
	linepositions[onda] = position*2
  end
  --conjunto de blocos de colisoes dos elementos da cidade
  rects = {}
  for rec = 1,citySize do
	table.insert(rects,HC.rectangle(linepositions[rec], love.graphics.getHeight() - 40 - cities[rec].y/2, cities[rec].x, cities[rec].y))
  end
end

--funcao de tiro
function newShot(wei,hei,vl)
	return {
		x=wei,
		y=hei,
		v=vl/20 + 2,
		carga=vl,
		hit=0
	}
end

function love.update (dt)
 --controle de telas de abertura
 if aboutTIME > 0 or presentsTIME > 0 or shitTIME > 0 then
	aboutTIME = aboutTIME -1
	presentsTIME = presentsTIME -1
	shitTIME = shitTIME -1
 else
 if playGameMusic then
	music = love.audio.newSource("som/trilha.ogg")
	music:setVolume(4)
	music:setLooping(true)
	love.audio.play(music)
	playGameMusic = false
  end
  --move o jogador, atira e reinicia
  if love.keyboard.isDown('up') then		
		if(player.y > 0) then
			plr:moveTo(love.graphics.getWidth()/2,player.y - 1.5)
			player.y = player.y - 1.5
		end
  end
  if love.keyboard.isDown('down') then
		if(player.y < love.graphics.getHeight()) then
			plr:moveTo(love.graphics.getWidth()/2,player.y + 2)
			player.y = player.y + 2
		end
  end
  if love.keyboard.isDown('left') then
		if(player.x > 0) then
			plr:moveTo(player.x - 1.7,player.y)
			player.x = player.x - 1.7
		end
  end
  if love.keyboard.isDown('right') then
		if(player.x < love.graphics.getWidth()) then
			plr:moveTo(player.x + 1.7,player.y)
			player.x = player.x + 1.7
		end
  end
  if love.keyboard.isDown('s') then
	if player.carregamento > 20 then
		peido = love.audio.newSource("som/peido.mp3")
		peido:setVolume(10)
		love.audio.play(peido)
		shot = newShot(player.x,player.y, player.carregamento)
		table.insert(fires,shot)
		table.insert(firesCirc,HC.circle(shot.x, shot.y, 3, player.carregamento/3))
		player.carregamento = 0
		fireCount = fireCount + 1
	end
  end
  if love.keyboard.isDown('n') then
	love.load()
  end
  --verifica colisoes	
  for shape, delta in pairs(HC.collisions(plr)) do
	for rec = 1,citySize do
		if shape == rects[rec] then
			plash = love.audio.newSource("som/plash.mp3")
			plash:setVolume(6)
			love.audio.play(plash)
			on = false
			win = false
		end
	end
  end
  for s = 1,fireCount do
	for shape, delta in pairs(HC.collisions(firesCirc[s])) do
	  for rec = 1,citySize do
		if shape == rects[rec] then
			if fires[s].hit == 0 then
				if cities[rec].adulto then
					pomba = love.audio.newSource("som/pomba.mp3")
					pomba:setVolume(10)
					love.audio.play(pomba)
				end
				if cities[rec].crianca then
					ahh = love.audio.newSource("som/ahh.mp3")
					ahh:setVolume(10)
					love.audio.play(ahh)
				end
				plash = love.audio.newSource("som/plash.mp3")
				plash:setVolume(6)
				love.audio.play(plash)
				cities[rec].img = cities[rec].shited
				HITpnt = 1*fires[s].carga*cities[rec].bonus
				pnts = pnts + HITpnt
				timer = timer + HITpnt*4
			end
			fires[s].hit = 1
			if cities[rec].major then
				cities[rec].vida = cities[rec].vida - fires[s].carga
				if cities[rec].vida < 0 then
					on = false
					win = true
				end
			end
		end
	  end
	end
  end
  if linepositions[citySize] < 0 then
	on = false
	win = true
	endCity = true
  end
  --incremento de velocidade c relacao a altura de voo
  incrVel = (love.graphics.getHeight() - player.y)/love.graphics.getHeight() + 0.01
  --move os personagens do computador
  if on then
	if player.carregamento < 80 then
		player.carregamento = player.carregamento + 0.3
	end
	local indexRect = 1
	while rects[indexRect] do
    	rects[indexRect]:moveTo(linepositions[indexRect] - 1 - cities[indexRect].vel/incrVel,  love.graphics.getHeight() - 50 - cities[indexRect].y/2)
		linepositions[indexRect] = linepositions[indexRect] - 1 - cities[indexRect].vel/incrVel
		indexRect = indexRect + 1
    end
	local indexFire = 1
	while firesCirc[indexFire] do
		if(fires[indexFire].y < love.graphics.getHeight() + 40) then
			firesCirc[indexFire]:moveTo(fires[indexFire].x, fires[indexFire].y + fires[indexFire].v)
			fires[indexFire].y = fires[indexFire].y + fires[indexFire].v
		end
		indexFire = indexFire + 1
    end
	timer = timer - 1
  end
  if timer < 0 then
	tm = false
	on = false
	win = false
  end
  fndMOVE = fndMOVE - 0.2
  spriteCount = spriteCount + 0.25
  if spriteCount > 1 then
	player.img = playerSprite[1]
  end
  if spriteCount > 2 then
	player.img = playerSprite[2]
  end
  if spriteCount > 3 then
	player.img = playerSprite[3]
  end
  if spriteCount > 4 then
	player.img = playerSprite[4]
  end
  if spriteCount > 5 then
	player.img = playerSprite[5]
  end
  if spriteCount > 6 then
	player.img = playerSprite[6]
  end
  if spriteCount > 7 then
	player.img = playerSprite[7]
  end
  if spriteCount > 8 then
	player.img = playerSprite[8]
  end
  if spriteCount > 9 then
	player.img = playerSprite[9]
  end
  if spriteCount > 9 then
	spriteCount = 1
  end
 end
 cloudMOVE = cloudMOVE - 0.5
end

function love.draw ()
 --controle de inicio do jogo
 if aboutTIME > 0 or presentsTIME > 0 or shitTIME > 0 then	
	love.graphics.setColor(255,255,255)
	if aboutTIME > 0 then
		if playTactac then
			tactac = love.audio.newSource("som/tactac.mp3")
			tactac:setVolume(10)
			love.audio.play(tactac)
			playTactac = false
		end
		love.graphics.setBackgroundColor(30,155,205)
		love.graphics.draw(about, 0, 0)
	else if presentsTIME > 0 then
		if playParan then
			paran = love.audio.newSource("som/paran.mp3")
			paran:setVolume(8)
			love.audio.play(paran)
			playParan = false
		end
		love.graphics.setBackgroundColor(30,155,205)
		love.graphics.draw(presents, 0, 0)
		love.graphics.draw(smoke, cloudMOVE, 0)
		love.graphics.draw(cloud, 280, -200)
	else
		love.graphics.setBackgroundColor(30,155,205)
		love.graphics.draw(shit, 0, 0)
	end
	end
 else
  if on then
	--fundo e informacoes
	love.graphics.setBackgroundColor(30,155,205)
	love.graphics.draw(fnd, fndMOVE, 0)
	love.graphics.setColor(175,175,175)
	love.graphics.rectangle("fill", 20, 10, 80, 15)
	love.graphics.setColor(255,255,255)
	love.graphics.print(timer, love.graphics.getWidth() - 90, 20)
	love.graphics.print(pnts, 40, love.graphics.getHeight() - 25)
	love.graphics.print("( + ", 100, love.graphics.getHeight() - 25)
	love.graphics.print(HITpnt, 120, love.graphics.getHeight() - 25)
	love.graphics.print(" )", 160, love.graphics.getHeight() - 25)
	if player.carregamento > 20 then
		love.graphics.setColor(0,255,0)
	end
	love.graphics.rectangle("fill", 20, 10, player.carregamento, 15)
	--desenha as formas dos personagens
	love.graphics.setColor(30,175,205,0)
	plr:draw('fill')
	love.graphics.setColor(0,0,0)
	local indexRect = 1
	while rects[indexRect] do
    	rects[indexRect]:draw('fill')
		indexRect = indexRect + 1
    end
	love.graphics.setColor(255,255,255)
	--desenha os tiros do jogador
	local indexFire = 1
	while firesCirc[indexFire] do
		if fires[indexFire].hit == 0 then
			firesCirc[indexFire]:draw('fill')
		end
		indexFire = indexFire + 1
    end
	love.graphics.setColor(255, 255, 255)
	--coloca as imagens sobre as formas
	local indexRect = 1
	while cities[indexRect] do
    	love.graphics.draw(cities[indexRect].img, linepositions[indexRect] - cities[indexRect].img:getWidth()/2, love.graphics.getHeight() - 40 - cities[indexRect].img:getHeight())
		indexRect = indexRect + 1
	end
	love.graphics.draw(player.img, player.x - player.img:getWidth()/2, player.y - player.img:getHeight()/2)
  else
  --trata o fim do jogo
	if win then
		if playVictory then
			music:stop()
			victory = love.audio.newSource("som/victory.mp3")
			victory:setVolume(6)
			love.audio.play(victory)
			playVictory = false
		end
		if endCity then
			love.graphics.setColor(0, 0, 255)
			love.graphics.draw(vic, 0, 0)
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("YOU SHITED ALL CITY! CONGRATULATIONS!", 300, love.graphics.getHeight()/2)
			love.graphics.print("POINTS:", 200, 420)
			love.graphics.print(pnts, 260, 420)
		else
			love.graphics.setColor(0, 0, 255)
			love.graphics.draw(vic, 0, 0)
			love.graphics.setColor(255, 255, 255)
			love.graphics.print("YOU SHITED THE MAJOR TO DEATH! YOU ARE A NOTABLE KILLER!", 300, love.graphics.getHeight()/2)
			love.graphics.print("POINTS:", 200, 420)
			love.graphics.print(pnts, 260, 420)
		end
	else
		if playLose then
			music:stop()
			hahaha = love.audio.newSource("som/hahaha.mp3")
			hahaha:setVolume(5)
			love.audio.play(hahaha)
			playLose = false
		end
		if tm then
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(over, 0, 0)
			love.graphics.setColor(255, 0, 0)
			love.graphics.print('SPLASH! SMASHED!', 140, 400)
			love.graphics.setColor(0, 55, 200)
			love.graphics.print("PRESS 'n' TO START A NEW GAME!", 140, 440)
			love.graphics.print("POINTS:", 140, 420)
			love.graphics.print(pnts, 200, 420)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(over, 0, 0)
			love.graphics.setColor(255, 0, 0)
			love.graphics.print('TIME IS OVER!', 140, 400)
			love.graphics.print('HIT THE TARGETS TO WIN MORE TIME!', 80, 440)
			love.graphics.setColor(0, 55, 200)
			love.graphics.print("PRESS 'n' TO START A NEW GAME!", 80, 480)
			love.graphics.print("POINTS:", 140, 420)
			love.graphics.print(pnts, 200, 420)
		end
	end
  end
 end
end
