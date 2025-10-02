/* =========================================================================
   Consulta : fato_reviews
   Objetivo : Carregar a tabela fato de reviews do Olist para o modelo.
   Granularidade : 1 linha por review (id_review).
   Fonte    : CSV — \\wsl.localhost\Ubuntu-22.04\root\olist-pipeline\gold\fato_reviews.csv
   Delimitador: "," | Colunas: 7 | Codificação: 65001 (UTF-8)
   Esquema  :
     - id_review (text)
     - id_pedido (text)
     - id_cliente (text)
     - id_produto (text)
     - nota_review (Int64.Type)
     - data_criacao_review (date)
   Etapas   : Promover cabeçalhos → Definir tipos.
   Chave    : id_review
   Relações : fato_pedidos_pbi[id_pedido], dim_clientes_pbi[id_cliente],
              dim_produtos_pbi[id_produto]
   Carrega  : Sim (tabela no modelo)
   Última revisão : <preencha a data>
   Autor: Douglas Souza | Data: 2025-10-01 | Versão: 1.0
========================================================================= */

let
    Fonte = Csv.Document(File.Contents("\\wsl.localhost\Ubuntu-22.04\root\olist-pipeline\gold\fato_reviews.csv"),[Delimiter=",", Columns=7, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Cabeçalhos Promovidos" = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Cabeçalhos Promovidos",{{"id_review", type text}, {"id_pedido", type text}, {"id_cliente", type text}, {"id_produto", type text}, {"nota_review", Int64.Type}, {"data_criacao_review", type datetime}, {"id_tempo", Int64.Type}})
in
    #"Tipo Alterado"
