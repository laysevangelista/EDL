-- -----------------------------------------------------
-- Tarefa 08 - Tarefa extra - closures e co-rotinas
-- Elaborado por: Lays F. E. Popova
-- Disciplina: Estruturas de Linguagem
-- -----------------------------------------------------
timer1=os.time()
-- tarefa-06 -> registro
player = {
  imagem=nil,
  x   = nil,
  y = nil,
  width = nil,
  img={},
  height     = nil,
  vivo       = nil,
  speed = 190
}

itens={}
obj = {} -- tarefa-06 -> array

window = {
	width = nil,
	height=nil
}

cont = 0 -- contador total



-- Tarefa 08 - Closure que cria um item
function novoObj(x, y, s) -- coordenadas x,y e s-> velocidade
  local me; me = {
    move = function(dx, dy)
      x = x + dx
      y = y + dy
      return x, y
    end,

    get = function()
      return x, y
    end,
	
	
    -- Tarefa 08 - Co-rotina que faz a obj Retr em movimento retangular
    coRet = coroutine.create(function(dt)
      while true do
        for i = 1,35 do
          me.move(0, 2*s*dt)
          dt = coroutine.yield()
        end

        for i = 1, 35 do
          me.move(-s*dt, 0)
          dt = coroutine.yield()
        end

        for i = 1, 35 do
          me.move(0, -s/2*dt)
          dt = coroutine.yield()
        end

        for i = 1, 35 do
          me.move(s*dt, 0)
          dt = coroutine.yield()
        end
      end 
    end),
	
  }
  
  return me
end

-- tarefa-08 criação do objeto
criaObj = function()
  for i = #obj.instancia + 1, 10 do
 
    math.randomseed(os.time() + i)
    
    -- Tarefa 08 - Criando uma obj
    obj.instancia[i] = novoObj((math.random(0, 10) * 100), 0, 250)

    local Ret = math.random(0, 1)

    if Ret == 0 then
      obj.instancia[i].Ret = false
	  
    else
      obj.instancia[i].Ret = true
	  
	  
    end
  end
end
--tarefa-08 movendo o objeto
movimentaObj = function(dt)
  -- Tarefa 08 - 
  
  for i = #obj.instancia, 1, -1 do
    if obj.instancia[i].Ret then
      coroutine.resume(obj.instancia[i].coRet, dt)
    end
  end
end


-- tarefa-08 assim que o objeto passa do comprimento da tela, ele é removido do jogo
removeObj = function(dt)
  for i = #obj.instancia, 1, -1 do

    local x, y = obj.instancia[i].get()

    if y >= window.height - obj.height then
      table.remove(obj.instancia, i)
    end
  end
end

-- tarefa-08 ao colidir com o player, o jogo acaba
colisaoPlayerObj = function(dt)
  for i = #obj.instancia, 1, -1 do

    local x, y = obj.instancia[i].get()

    if player.y+ player.height >= y and player.y <= y + obj.height
		and player.x + player.width >= x and player.x <= x + obj.width then
			player.vivo=false 
			 
    end
  end
 end


-- -------------------------------------------------

function love.load()
 titulo='Alimente o Cão'
  -- Inicializações
  pause = false
  -- window
  window.width    = 900
  window.height   = 700
  background = love.graphics.newImage('assets/background.png')
-- player
  player.x = 50
  player.y = 415
  player.width=128
  player.height=128
  player.imagem = love.graphics.newImage('assets/player-animated.png')
  player.vivo = true
-- layout tela 
  love.window.setMode(window.width, window.height)
  love.window.setTitle(titulo)
  love.graphics.setFont(love.graphics.newFont(18))

  -- obj
 
  obj.imagemRet1=love.graphics.newImage('assets/stick.png')
  obj.width =15
  obj.height =15
  obj.instancia = {}

  
end

function love.update (dt)
 if not pause then -- se o jogo não estiver pausado
  sprite = player.imagem

  if player.vivo then
    if love.keyboard.isDown("left") and player.x > 0 then
      player.x = player.x - (player.speed * dt);
    end
    if love.keyboard.isDown("right") and player.x < window.width - player.width then
      player.x = player.x + (player.speed * dt);
    end
 --[[  if love.keyboard.isDown("up") and (player.y > 0) then
      player.y = player.y - (player.speed * dt);
    end
    if love.keyboard.isDown("down") and (player.y < window.height - player.height) then
      player.y = player.y + (player.speed * dt);
    end ]]
-- tarefa-08 uso das co-rotinas
    criaObj()
    movimentaObj(dt)
    colisaoPlayerObj(dt)
    removeObj()
  end
 end 
end

function love.draw()
  -- Background
  love.graphics.draw(background, 0, 0)

  if player.vivo then
   -- love.graphics.printf("Total: "..cont, 10, 10, 9999) -- pontuação total
	--love.graphics.printf("Carne: "..contC, 10, 35, 9999) -- pontuação das carnes comidas
	--love.graphics.printf("Ossinho: ", 10, 60, 9999) -- pontuação dos ossinho comidos
	love.graphics.printf("Tempo: "..os.time()-timer1, 190,10,9999) --faz a contagem do tempo de atividade do jogo
	love.graphics.printf("Esc -> sair", 410,10,9999)
	love.graphics.printf("Space -> pausar / despausar", 600,10,9999)

  -- player
	love.graphics.draw(player.imagem,  player.x,player.y)

	for i = 1, #obj.instancia do

		local x, y = obj.instancia[i].get()
    -- Tarefa 08 - associando o objeto a imagem
		if obj.instancia[i].Ret then
			love.graphics.draw(obj.imagemRet1, x, y)
		end
	end
  if pause then 
	 player.vivo="jogo pausado"
	 love.graphics.print(player.vivo, 370, 250) 
	 player.vivo=true
  end 

 else
	love.graphics.printf("GAME OVER ".."Doguinho", 350, 255, 9999)
	love.graphics.printf(cont.." pontos", 410, 290, 9999)
    love.graphics.printf(" Pressione 'Enter' para reiniciar ", 325, 320, 9999)
	
  end
end

function love.keypressed(k)

  if k == 'escape' then
    love.event.quit();
  end
  if k== 'space' then
		pause = not pause
  end
  if k == 'return' then -- colocar o reiniciar pra ajudar no teste
		love.load()
  end	
-- tarefa-05
-- Nome: variável “k”
-- Propriedade: endereço
-- Binding time: execução
-- Explicação: dado que “k” é uma variável
-- local de uma função, seu conteúdo será
-- determinado em tempo de execução, ou seja, 
-- quando o evento de pressionar o teclado ocorrer
-- se for 'escape' o evento "sair" será acionado
-- se for 'space' o evento "pausar" será acionado  
end