-- -----------------------------------------------------
-- Tarefa 06 - Tipos de Dados
-- Elaborado por: Lays F. E. Popova
-- Disciplina: Estruturas de Linguagem
-- -----------------------------------------------------

background = love.graphics.newImage ('assets/fundo.png')

-- tarefa-06 -> registro
player = {
  imagem=nil,
  x   = nil,
  y = nil,
  width = nil,
  img={}, --tarefa-06 -> array
  height     = nil,
  vivo       = nil,
  speed = 190,
  come=nil
}
itens = {} -- tarefa-06: -> table utilizado como Array, linhas 149 | 160 |174
-- tarefa-05
--Nome: Variável "itens"
--Propriedade: Endereço
--Binding time: Compilação
--Explicação: Como a variável em questão é global, a alocão de espaço na memória se dá em tempo de compilação.
window = {}

timer1=os.time()

function love.load()
  
  titulo='Alimente o Cão' 
  love.window.setTitle(titulo) --título do jogo 
  -- tarefa-05
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
  -- tarefa-05
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
  player.vivo = 1 -- se player não esta vivo = game over . 1 = vivo e 0 = game over
  player.speed = 190 -- velocidade

  player.come = 0
  itens.maxSimultaneousitens = 2
  itens.types = {} -- tarefa-06 tupla(finita)
  
  -- itens disponíveis : ossinho ; carne ; stick
  itens.types[1] = "ossinho"
  itens.types[2] = "carne"
  itens.types[3] = "stick"
  -- carregamento das imagens
  itens.images = {}
  itens.images["ossinho"] = love.graphics.newImage('assets/ossinho.png')
  itens.images["carne"] = love.graphics.newImage('assets/carne.png')
  itens.images["stick"] = love.graphics.newImage('assets/stick.png')

  itens.dimensions = {}
  itens.dimensions["ossinho"] = {}
  itens.dimensions["ossinho"].width, itens.dimensions["ossinho"].height = itens.images["ossinho"]:getDimensions()
  itens.dimensions["carne"] = {}
  itens.dimensions["carne"].width, itens.dimensions["carne"].height = itens.images["carne"]:getDimensions()
  itens.dimensions["stick"] = {}
  itens.dimensions["stick"].width, itens.dimensions["stick"].height = itens.images["stick"]:getDimensions()
  --contadores
  itens.instances = {}
  cont = 0 --contador total
  
  contC = 0 -- contador das carnes
  contO = 0 -- contador dos ossinhos
end

function love.update(dt)
 if not pause then -- se o jogo não estiver pausado
	-- se o jogador estiver ativo
  if player.vivo == 1 then
 
    player.come = 0
    -- movimetnação do cachorro
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
    -- Tarefa-05
    -- Nome: Operador #
    -- Propriedade: Semântica
    -- Binding time: Design
    -- Explicação: O operador # recebe o tamanho de um array/vetor foi atribuido no período do design da linguagem.
      math.randomseed( os.time() + i )
      itens.instances[i] = {} -- tarefa-07 Criando array de dos itens a colidirem com o player. Escopo global
      itens.instances[i].x = window.width
      itens.instances[i].speed = math.random(390,800);
      -- Tarefa-05
      -- Nome: Função math.random()
      -- Propriedade: Semântica
      -- Binding Time: Design 
      -- Explicação: math.random() é uma função nativa da biblioteca padrão de LUA
      -- com isso sua implementação e nome foram definidos no tempo de design da linguagem.
      itens.instances[i].type = itens.types[math.random(1, #itens.types)];
	  itens.instances[i].y = (math.random(0, window.height - itens.dimensions[itens.instances[i].type].height))
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

           if b.type == "ossinho" then -- pontuação ao comer os ossinhos
			  contO = contO + 150
			  cont=cont+contO
             table.remove(itens.instances, i)
			 --tarefa-05
			 -- Nome: table.remove (table)
			 -- Propriedade: implementação
		     -- Binding time: Design
		     -- Explicação: Arrays, vetores, matrizes e classes são todos um table em lua. 
			 -- Table é o único contêiner que existe em lua, como uma variável representando vários valores dentro dela. 
			 -- Esse container pode ser adicionado ou removido a hora que quiser, sendo sua implementação definida durante o design da linguagem.
		   elseif b.type =="carne" then -- pontuação ao comer as carnes
			 contC = contC +250
			 cont=cont+contC
			 table.remove(itens.instances, i)
			  -- tarefa-05
			  -- Nome: variável “cont”
			  -- Propriedade: valor
              -- Binding time: execução
			  -- Explicação: dado que “cont” é uma variável
              -- que possui vinculação dinâmica, uma vez que 
			  -- ela está tendo o seu conteúdo alterado durante 
			  -- o tempo de execução.			 
		  elseif b.type == "stick" then -- muda o status de ativo e determina o fim do jogo
			player.vivo=0
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
  if player.vivo == 1 then
	-- joga na tela a pontuação total , a das carnes , ossinhos e tempo de jogo
    love.graphics.printf("Total: "..cont, 10, 10, 9999) -- pontuação total
	love.graphics.printf("Carne: "..contC, 10, 35, 9999) -- pontuação das carnes comidas
	love.graphics.printf("Ossinho: "..contO, 10, 60, 9999) -- pontuação dos ossinho comidos
	love.graphics.printf("Tempo: "..os.time()-timer1, 225,10,9999) --faz a contagem do tempo de atividade do jogo
	love.graphics.printf("Esc -> sair", 410,10,9999)
	love.graphics.printf("Space -> pausar / despausar", 600,10,9999)
	-- se player.vivo == 0, é declarado o fim do jogo	
  elseif player.vivo ==0 then
	love.graphics.printf("GAME OVER", 400, 260, 9999)
    love.graphics.printf(cont.." pontos", 410, 290, 9999)

  end	
  -- jogo pausado
  if pause then 
	love.graphics.print("Jogo Pausado", 370, 250) 
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
--tarefa-05
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