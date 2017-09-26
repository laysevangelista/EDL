# Linguagem R

## Introdução
<p>
R é uma linguagem e um ambiente de desenvolvimento voltado principalmente para computação estatística e na elaboração de gráficos. 
Com conceitos como big data e IoT ganhando mais espaço como geradoras de dados, a popularidade da plataforma vem ganhando mais adeptos nos últimos anos desde a sua implementação.
</p>

## Origens e Influências
<p>Desenvolvido originalmente por Ross Ihaka e Robert Gentleman (Depto Estatística da Universidade de Auckland, Nova Zelândia) no ano de 1993 com o intuito de auxiliar o ensino de estatística a seus alunos, pois na época a maioria dos softwares utilizados eram pagos.</p>
<p>R é inspirado em duas linguagens: Para a parte sintática temos o S , desenvolvida por  (John Chambers e colegas – Bell Labs), na década de 70 que também era uma linguagem de voltada para cálculos estatísticos e para a parte de implementação e semântica foi inspirada no Scheme (Hal Abelson e Gerald Sussman) que suporta programação funcional e procedural.</p>
<p>Em junho de 1995 R foi disponibilizado como um software livre e em 1997, já possuindo uma certa visibilidade mundial, começou a ter um aumento  no número de desenvolvedores participando de equipes de desenvolvimento do R, entre eles um dos idealizadores e criadores da linguagem S, John Chambers.</p>


## Classificação

<p>Podemos definir que R é uma linguagem imperativa e orientada a ações ,pois permite que o usuário envie um comando por vez e assim recebendo um resultado. Ela é orientada a objetos e dinâmica (linguagem de scripting).</p>
<p>Na maioria dos casos  as análises estatísticas são realizadas sobre um conjunto de dados (uma matriz, onde as linhas estão associadas às unidades observadas e as colunas às variáveis em estudo). Em geral,  os dados são digitados usando programas próprios para digitação ou na utilização de planilhas eletrônicas. </p>
<p>A linguagem possui inúmeras funções pré definidas para a realização de cálculos de álgebra linear e não-linear, bem como manipulação destas estruturas. </p>
<p>Para instalar um pacote podemos ir no Site do R e escolher os pacotes a serem instalados, ou caso o computador tenha acesso a internet  é possível  instalar e atualizar pacotes sem que seja necessário acessar a página do R.</p>
<p>R não é considerada uma linguagem muito legível para muitos usuários (Readability) isso se deve ao fato de a maioria dos usuários que disponibilizam códigos online, não são ligados a área de computação, ou seja, em muitos dos casos os códigos apresentados precisam de um certo esforço para devido conhecimento além de possibilitar diversas implementações para um determinado fim, o que pode gerar uma certa confusão.</p>
<p>Entretanto,  como é uma linguagem amplamente utilizada por estatísticos e analistas de dados, ela é considerada uma linguagem fácil de ser escrita. Quando o assunto se trata sobre processamento e visualização de dados, R proporciona muitas possibilidades com muito pouco a ser escrito, quando o desenvolvedor sabe o que está fazendo.</p>

## Avaliação Comparativa


<p>A nível de comparação, optar por uma linguagem para um trabalho de data science depende de um amplo espectro de fatores relacionados às condições disponíveis para o projeto que a de ser implementado, para tal será utilizado a linguagem Python que também é largamente utilizada para análise de dados. </p>
<p>Além de ambas as linguagens serem consideradas de simples aprendizado, podemos atribuir como um ponto positivo a linguagem R,possui uma abundância de pacotes lançados publicamente (mais de 5.000), que podem ser baixados para estender as capacidades da linguagem. Isso faz R uma ótima opção para a execução de complexas análises de dados exploratórios além de se integrar bem com outras linguagens de programação como C ++, Java e C.</p>
<p>Python é uma linguagem de programação de uso geral, embora esta não tenha um conjunto de pacotes e bibliotecas tão abrangente como os disponíveis comparado a R, a combinação de Python com ferramentas como Pandas, Numpy, Scipy, Scikit-learn e Seaborn, torna a linguagem uma escolha viável entre os Cientistas de Dados. A linguagem também está lentamente se tornando útil para tarefas em Machine Learning e de base para o trabalho estatístico intermediário (anteriormente apenas sob o domínio de R). </p>

##  Exemplos de código representativos

<p> A seguir encontram-se alguns exemplos de algoritmos mais comumente utilizados em Machine Learning, eles podem ser utilizados para quase todos os problemas com dados.
São Eles:
  
 - Regressão Logística 
 - K-Means
 - Algoritmo de Redução de Dimensionalidade
  
</p>

**Regressão Logística** => prevê a probabilidade da ocorrência de um evento, ajustando os dados a uma função logística.

<p> R
   <pre><code>
> x <- cbind(x_train,y_train) 
> logistic <- glm(y_train ~ ., data = x,family='binomial')
> summary(logistic) #saída
> predicted= predict(logi)
</pre></code>
 </p> 
 
<p> Python
<pre><code>  
#Import Library
from sklearn.linear_model import LogisticRegression
#Assumed you have, X (predictor) and Y (target) for training data set and x_test(predictor) of test_dataset
# Create logistic regression object
model = LogisticRegression()
# Train the model using the training sets and check score
model.fit(X, y)
model.score(X, y)
#Equation coefficient and Intercept
print('Coefficient: \n', model.coef_)
print('Intercept: \n', model.intercept_)
#Predict Output
predicted= model.predict(x_test)
</pre></code>
 </p> 
 
**K-Means** => É um tipo de algoritmo sem supervisão que resolve problemas de agrupamento.

<p> R
   <pre><code>
> library(cluster)
> fit <- kmeans(X, 3) 
</pre></code>
 </p> 
 
 <p> Python
  <pre><code>
#Import Library
from sklearn.cluster import KMeans
#Assumed you have, X (attributes) for training data set and x_test(attributes) of test_dataset
# Create KNeighbors classifier object model 
k_means = KMeans(n_clusters=3, random_state=0)
# Train the model using the training sets and check score
model.fit(X)
#Predict Output
predicted= model.predict(x_test)
</pre></code>
</p>

**Algoritmo de Redução de Dimensionalidade**

<p> R
  <pre><code>
> library(stats)
> pca <- princomp(train, cor = TRUE)
> train_reduced  <- predict(pca,train)
> test_reduced  <- predict(pca,test)
</pre></code>
</p>

<p> Python
  <pre><code>
  #Import Library
  from sklearn import decomposition
  #assumindo que os dados já foram validados e testados previamente
  # Create PCA obeject pca= decomposition.PCA(n_components=k) #default value of k =min(n_sample, n_features)
  #fa= decomposition.FactorAnalysis()
  #Reduz a dimensão utilizando PCA
  train_reduced = pca.fit_transform(train)
  #Reduz a dimensão de test dataset
  test_reduced = pca.transform(test)
</pre></code>
</p>


## Conclusão
<p> 
Após a implementação de praticamente as mesmas atividades em ambas as linguagens, fica evidente que R possui um menor esforço (linhas de código produzido) para desempenhar as mesmas ações em comparação com Python. Podemos observar ainda uma clara inspiração de Python nos dataframes R, como também a existência de pequenos pacotes R inspirados em bibliotecas Python, podendo assim ser inferido que ambas as linguagens são as boas escolhas para atuar em data science.

</p>

## Referência Bibliografica

[Marcelo de Souza Lauretto ,Introdução à Análise de Dados Utilizando o Ambiente R](http://each.uspnet.usp.br/lauretto/cursoR2015/cursoR2015.pdf)

[Victor Lemes Landeiro, Instituto Nacional de Pesquisas da Amazônia Coordenação de Pesquisas em Ecologia](https://cran.r-project.org/doc/contrib/Landeiro-Introducao.pdf)

[Cálculo PCA] (http://scikit-learn.org/stable/modules/decomposition.html#decompositions)

[Infográfico R vs Python] (https://www.datacamp.com/community/tutorials/r-or-python-for-data-analysis#gs.zc0Qw3M)

[Python vs R para machine learning e análise de dados](http://propus.science/python-versus-r-para-machine-learning-e-analise-de-dados/)
