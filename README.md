### Contexto do projeto

Este repositório apresenta a estrutura ELT do projeto Certificação Analytics Engineer pela Indicium. Os dados são extraídos. Todas as tabelas do banco fonte do SAP da Adventure Works serão carregadas como seeds pelo dbt e armazenados no Bigquery, a transformação dos dados em modelo dimensional star schema ocorre através do dbt e a visualização de dados foi realizada utilizando Power BI desktop.

## Passo a passo para inicialização do projeto

### Clonando o projeto
Primeiramente, é necessário clonar o repositório localmente. O projeto pode ser clonado via SSH ou HTTPS utilizando-se o comando `git clone` no link.
- `https://github.com/jgsjuliana/academy-dbt.git`

### Criando um ambiente virtual
Será necessária a criação de um ambiente virtual na pasta home do projeto.
- `python3 -m venv venv` ou
- `py -3.8 -m venv venv` para Bash no Windows.
A **versão do Python** utilizada neste projeto é a **3.8.10**.

### Ativação do ambiente virtual
Ao criar a vitual env, será preciso realizar a ativação do ambiente.
- `source venv/bin/activate` no Linux ou
- `source venv/Scripts/activate` em bash no Windows, ou ainda
- `.\venv\Scripts\activate.ps1` no Windows PowerShell

Garanta que você está na pasta onde o ambiente virtual foi criado. Se ele for ativado corretamente, o terminal terá uma flag apontando ***(venv)*** na frente do nome do usuário antes de cada comando. Para desativar o ambiente virtual, basta rodar: 

- `deactivate`.

Esse projeto utiliza git para o controle de versionamento. Indica-se a criação de uma branch para cada etapa do processo.

### Instalando as bibliotecas

Para instalação das bibliotecas precisamos executar o comando `pip install -r requirements.txt` na linha de comando.

### Configurando o profiles.yml

Altere o profiles.yml e o dbt_project.yml do arquivo para as configurações do seu projeto e data warehouse.

## Transformação no dbt

### Carregamento dos arquivos para um Data Warehouse

Utilize o dbt debug para verificar se suas credenciais foram configuradas corretamente com o comando:
$ dbt debug
Caso retorne a mensagem "All checks passed!", poderá seguir com o projeto.

Todas as tabelas do banco fonte do SAP da Adventure Works foram carregadas como seeds pelo dbt. Os arquivos .csv com os dados, estão na pasta de seeds.
Para fazer o carregamento de todas as tabelas usem o comando:
- `dbt seed`

Para carregar uma tabela especifíca utilizem o comando
- `dbt seed -s nome_do_csv`

Ao iniciar a trasformação de dados, espera-se uma estrutura de pastas no seguinte formato:

```yml
\models
  \sales
    \staging
    \intermediate
    \marts
\tests
  \sales
```

Utilize dbt run para verificar se todas as suas tabelas rodaram e foram criadas.
$ dbt run

Utilize o dbt test para validar os testes de sources e os testes de dados, garantindo a integridade de dados.
$ dbt test

Para rodar, compilar e testar o projeto ao mesmo tempo, utilize o comando:
$ dbt build

O projeto também contou com extensão do SQL Fluff para verificar o code style do projeto e a documentação para atender ao padrão de nomenclatura.

### Detalhes desse projeto
Esse projeto conta com a modelagem apenas para a área de vendas (sales) da Adventure Works. Foram criadas as dimensões de produtos, clientes, motivo de venda, cartão de crédito e localidade. A tabela fato foi criada a partir das tabelas de `sales order header` e `sales order detail`. E foi necessária a criação de uma bridge table para união da tabela fato e dimensão de motivo de venda para evitar o relacionamento muitos para muitos.

## Documentação
A documentação do projeto, após a criação dos arquivos .yml com o detalhamento de colunas e testes de dados, pode ser gerada através do comando:

- `dbt docs generate`

Após o comando, será criada uma pasta target com a documentação. Para visualizar a documentação, ou seja, interpretar a pasta target, deve-se usar:

- `dbt docs serve` - que hospeda um servidor local e monta a documentação.

## Visualização de dados
A visualização de dados foi desenvolvida no Power BI desktop para responder as seguintes perguntas de negócio:

- **a** - Qual o número de pedidos, quantidade comprada, valor total negociado por produto, tipo de cartão, motivo de venda, data de venda, cliente, status, cidade, estado e país?
- **b** - Quais os produtos com maior ticket médio por mês, ano, cidade, estado e país? (ticket médio = Faturamento bruto - descontos do produto / número de pedidos no período de análise)
- **c** - Quais os 10 melhores clientes por valor total negociado filtrado por produto, tipo de cartão, motivo de venda, data de venda, status, cidade, estado e país?
- **d** - Quais as 5 melhores cidades em valor total negociado por produto, tipo de cartão, motivo de venda, data de venda, cliente, status, cidade, estado e país?
- **e** - Qual o número de pedidos, quantidade comprada, valor total negociado por mês e ano (dica: gráfico de série de tempo)?
- **f** - Qual produto tem a maior quantidade de unidades compradas para o motivo de venda “Promotion”?

## Ferramentas utilizadas
- Python 3.8.9
- dbt core 1.4.6
- dbt bigquery 1.4.3
- Power BI desktop

## Recursos:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](http://community.getbdt.com/) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices