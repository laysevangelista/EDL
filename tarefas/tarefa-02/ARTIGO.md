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
<p>Além de ambas as linguagens serem consideradas de simples aprendizado, podemos atribuir como um ponto positivo a linguagem R,que a mesma possui uma abundância de pacotes lançados publicamente (mais de 5.000), que podem ser baixados para estender as capacidades da linguagem. Isso faz R ótimo para a execução de complexas análises de dados exploratórios. Ela também se integra bem com outras linguagens de programação como C ++, Java e C.</p>
<p>Python é uma linguagem de programação de uso geral, embora Python não tenha um conjunto de pacotes e bibliotecas tão abrangente como os disponíveis para a linguagem R, a combinação de Python com ferramentas como Pandas, Numpy, Scipy, Scikit-learn e Seaborn, torna a linguagem uma escolha viável entre os Cientistas de Dados. A linguagem também está lentamente se tornando útil para tarefas em Machine Learning e de base para o trabalho estatístico intermediário (anteriormente apenas sob o domínio de R). </p>

##  Exemplos de código representativos

<p>Abaixo segue uma pequena amostra de tarefas que podem ser realizadas com ambas com R e Python. Podemos observar grande facilidade no trato sintático de R e Python. </p>

R
<p>
  <pre><code>
> coletivo <- read.csv("coletivos.csv");
> jogadores<-(coletivo$Numero.Jogadores);
> esporte<-(coletivo$Esportes);
> print(nrow(coletivo));
[1] 6
> print(ncol(coletivo));
[1] 2
Hit <Return> to see next plot:         
> barplot(jogadores, col= "darkgreen",main="Esportes Coletivos", xlab="Esportes", ylab="Numero de Jogadores", names.arg=coletivo$Esportes, border="black");
Hit <Return> to see next plot:         
> coletivo
  Esportes Numero.Jogadores
1  Futebol               11
2    Volei                6
3 Basquete                6
4    rugby               15
5 handebol                7
6     polo                4
> sapply(coletivo, mean, na.rm=TRUE);
        Esportes Numero.Jogadores 
              NA         8.166667 
> print(coletivo$Esportes);
[1] Futebol  Volei    Basquete rugby    handebol polo    
Levels: Basquete Futebol handebol polo rugby Volei
</pre></code>
  </p>  
  
 [Grafico em R](https://www.dropbox.com/s/jkk1norhl2rjnw2/Rplot01.png?dl=0)
 
 Python
<p>
<pre><code>  
import pandas as pd
df_coletivo = pandas.read_csv("coletivo.csv")
df = pd.DataFrame(df_coletivo)
print(df) # imprime coletivo, as linhas e colunas do dataframe
print(df_coletivo['Esportes']) # imprime as linhas do campo Esportes

 ['Futebol', 'Volei', 'Basquete', 'rugby', 'handebol', 'polo']


#para o gráfico

import plotly.plotly as py
from plotly.graph_objs import *
py.sign_in('username', 'api_key')
df_coletivo = {
 'Esportes': ['Futebol', 'Volei','Basquete', 'rugby', 'handebol','polo'],
  'Numero Jogadores': [11, 6, 6, 15, 7, 4], 
  "type": "bar"
}
data = Data([df_coletivo])
fig = Figure(data=data)
plot_url = py.plot(fig)

</pre></code>
 </p> 
 
[Grafico em Python](https://www.dropbox.com/s/77iha0b232x7ada/gPython.png?dl=0)

## Conclusão
<p> 
Após a implementação de praticamente as mesmas atividades em ambas as linguagens, fica evidente que R possui mais funções voltadas à análise de dados já Python opta pelo uso extensivo de métodos e classes, Ao analisar o pacote Pandas (utilizado para o código comparativo em Python) podemos observar uma clara inspiração nos dataframes R. É comum observarmos também pequenos pacotes R inspirados em bibliotecas Python e com isso afirmar que ambas as linguagens são as ideais para atuar em data science.

</p>

## Referência Bibliografica

[Marcelo de Souza Lauretto ,Introdução à Análise de Dados Utilizando o Ambiente R](http://each.uspnet.usp.br/lauretto/cursoR2015/cursoR2015.pdf)

[Linguagem R R-Gui e R-Commander ]( https://docs.ufpr.br/~taconeli/CE003M1/RCmdr.pdf)

[Victor Lemes Landeiro, Instituto Nacional de Pesquisas da Amazônia Coordenação de Pesquisas em Ecologia](https://cran.r-project.org/doc/contrib/Landeiro-Introducao.pdf)
