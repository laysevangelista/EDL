-- -----------------------------------------------------
-- Tarefa 05 - Bindings
-- Elaborado por: Lays F. E. Popova
-- Disciplina: Estruturas de Linguagem
-- -----------------------------------------------------

background = love.graphics.newImage ('assets/fundo.png')

player = {} -- tarefa-06 registro / tabela
itens = {}
window = {}
cont = {}
conterO={}
conterS={}
timer1=os.time()

function love.load()
  titulo='Alimente o Cão'
  love.window.setTitle(titulo) --título do jogo
          --1
  -- Nome: titulo
  -- Propriedade: nome
  -- Binding time: compilação
  -- Explicação:Uma vez que o tipo específico não é conhecido antes do tempo de execução , a função executada é vinculada dinamicamente.

  
  pause = false

  love.graphics.setFont(love.graphics.newFont(20)) -- tamanho da fonte
  window.height = 700 -- altura janela
  window.width = 900 -- largura janela
  love.window.setMode(window.width, window.height)
  player.image = love.graphics.newImage('assets/player-animated.png') -- jogador
            --2
  -- Nome: variável "player.image"
  -- Propriedade: tipo
  -- Binding time: compilação
  -- Explicação: dado que player.image recebe uma caracteristica (imagem)
  -- o objeto imagem é pre compilado antes do programa ser executado

  
  player.img = {} 
  -- dimensões do player
  player.img.standby = love.graphics.newQuad(0, 0, 128, 128, player.image:getDimensions())
  player.img.come = love.graphics.newQuad(128, 0, 128, 128, player.image:getDimensions())
  player.width, player.height = 128, 128

  player.x = 50
  player.y = 415
  player.vivo = true -- se player não esta vivo = game over . 1 = vivo , 0 = game over , pausa = jogo pausado
  player.speed = 190 -- velocidade

  player.come = 0
  itens.maxSimultaneousitens = 2
  itens.types = {} -- tarefa-06 array
  
  -- itens disponíveis : ossinho ; carne ; stick
  dic= {o = 'ossinho', c = 'carne', s='stick'} -- tarefa-06 dicionário
  itens.types[1] = dic.o
  itens.types[2] = dic.c
  itens.types[3] = dic.s
  -- carregamento das imagens
  itens.images = {}
  itens.images[dic.o] = love.graphics.newImage('assets/ossinho.png')
  itens.images[dic.c] = love.graphics.newImage('assets/carne.png')
  itens.images[dic.s] = love.graphics.newImage('assets/stick.png')

  itens.dimensions = {}
   
  itens.dimensions[dic.o] = {}
  itens.dimensions[dic.o].width, itens.dimensions[dic.o].height = itens.images[dic.o]:getDimensions()
  itens.dimensions[dic.c] = {}
  itens.dimensions[dic.c].width, itens.dimensions[dic.c].height = itens.images[dic.c]:getDimensions()
  itens.dimensions[dic.s] = {}
  itens.dimensions[dic.s].width, itens.dimensions[dic.s].height = itens.images[dic.s]:getDimensions()
  --contadores
  
  itens.instances = {}
  
  
  cont= 0 --contador total
  contC= 0 -- contador das carnes
  contO= 0 -- contador dos ossinhos
  perfil={'Doguinho',250,150} -- tarefa-06 tupla

end

function love.update(dt)
 if not pause then -- se o jogo não estiver pausado
	-- se o jogador estiver ativo
  if player.vivo == true then
 
    player.come = 0
    -- movimetnação do cachorro
	-- tarefa-06 ENUMERAÇÃO love.keyboard.isDown("left") , love.keyboard.isDown("right") , love.keyboard.isDown("up") , love.keyboard.isDown("down")
    if love.keyboard.isDown("left") and player.x > 0 then
      player.x = player.x - (player.speed * dt);
    end
    if love.keyboard.isDown("right") and player.x < window.width - player.width then
      player.x = player.x + (player.speed * dt);
    end
   if love.keyboard.isDown("up") and (player.y > 0) then
      player.y = player.y - (player.speed * dt);
    end
    if love.keyboard.isDown("down") and (player.y < window.height - player.height) then
      player.y = player.y + (player.speed * dt);
    end

    -- criação dos itens no jogo
    for i=(#itens.instances) + 1, itens.maxSimultaneousitens do
    -- tarefa-07
	-- os itens que colidem com o player (ossinhos, carne e stick) aparecem randomicamente no jogo
	-- respeitando as velocidades minimas e máximas (1) e tamanho da tela (2).
	-- eles desaparecem ou se o objeto colide com eles ou se cruzaram totalmente a tela , seguindo o fluxo
	-- da direita para a esquerda e quantidade variando de 1 a 2 (aparecendo em pares)
      math.randomseed( os.time() + i )
      itens.instances[i] = {} -- tarefa-06 tupla
      itens.instances[i].x = window.width
      itens.instances[i].speed = math.random(390,800); --(1)
      itens.instances[i].type = itens.types[math.random(1, #itens.types)]; 
	  itens.instances[i].y = (math.random(0, window.height - itens.dimensions[itens.instances[i].type].height)) --(2)

    end
    -- movimentação dos itens
    for i=#itens.instances, 1, -1 do
      local b = itens.instances[i]
      itens.instances[i].x = b.x - dt * b.speed
      if player.x < b.x + itens.dimensions[b.type].width and
         player.x + player.width > b.x and
         player.y < b.y + itens.dimensions[b.type].height and
         player.height + player.y > b.y then
           player.come = 1
		             --3
		     -- Nome: variável "player.x / player.y"
             -- Propriedade: endereço
             -- Binding time: design
             -- Explicação: dado que player.x e player.y direcionam o ato
             -- de "comer" , o posicionamento do player no ambiente de jogo vai sendo alterado.
           if b.type == "ossinho" then -- pontuação ao comer os ossinhos
			   contO = contO + perfil[3]
			  cont=cont+contO
             table.remove(itens.instances, i)
		   elseif b.type =="carne" then -- pontuação ao comer as carnes
			 contC = contC +perfil[2]
			 cont=cont+contC
			 table.remove(itens.instances, i)
			           --4
			  -- Nome: variável “cont”
			  -- Propriedade: valor
              -- Binding time: execução
			  -- Explicação: dado que “cont” é uma variável
              -- que possui vinculação dinâmica, uma vez que 
			  -- ela está tendo o seu conteúdo alterado durante 
			  -- o tempo de execução.

			 
		  elseif b.type == "stick" then -- muda o status de ativo e determina o fim do jogo
			player.vivo=false
          end 
      end
      if b.x <= 0 then
        table.remove(itens.instances, i)
      end
    end
  end
 end 

end

function love.draw()
  for i = 0, love.graphics.getWidth() / background:getWidth() do
    for j = 0, love.graphics.getHeight() / background:getHeight() do
      love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
    end
  end

  local sprite = player.img.standby
  if player.come == 1 then
    sprite = player.img.come
  end
  love.graphics.draw(player.image, sprite, player.x, player.y)
  for i=1, #itens.instances do
    local b = itens.instances[i]
    love.graphics.draw(itens.images[b.type], b.x, b.y)
  end
  if player.vivo then
	-- joga na tela a pontuação total , a das carnes , ossinhos e tempo de jogo
    love.graphics.printf("Total: "..cont, 10, 10, 9999) -- pontuação total
	love.graphics.printf("Carne: "..contC, 10, 35, 9999) -- pontuação das carnes comidas
	love.graphics.printf("Ossinho: "..contO, 10, 60, 9999) -- pontuação dos ossinho comidos
	love.graphics.printf("Tempo: "..os.time()-timer1, 225,10,9999) --faz a contagem do tempo de atividade do jogo
	love.graphics.printf("Esc -> sair", 410,10,9999)
	love.graphics.printf("Space -> pausar / despausar", 600,10,9999)

	-- se player.vivo ==false, é declarado o fim do jogo	
	 if pause then 
	 player.vivo="jogo pausado"
		love.graphics.print(player.vivo, 370, 250) 
		player.vivo=true
	end 
  else
	love.graphics.printf("GAME OVER "..perfil[1], 350, 260, 9999)
    love.graphics.printf(cont.." pontos", 410, 290, 9999)
	          --5
  -- Nome: variável "player.vivo"
  -- Propriedade: valor
  -- Binding time: design
  -- Explicação: dado que player.vivo recebe uma caracteristica (true vivo /false morto)
  -- o player morto muda a aparência do jogo.
  	
 
  end	
 

end
-- pausa e saida do jogo
function love.keypressed(k)
    if k == 'escape' then
         love.event.quit()
	end
	if k== 'space' then
		pause = not pause
		
	end	
	          --6
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

