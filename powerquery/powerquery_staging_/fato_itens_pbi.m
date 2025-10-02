// ---------------------------------------------
// Consulta: fato_itens_pbi
// Tabela destino: fato_itens_pbi
// Autor: Douglas Souza | Data: 2025-10-01 | Versão: 1.0
// Descrição: Carrega a fato de itens de pedido a partir do CSV do data mart,
//            promove cabeçalhos e define os tipos das colunas.
// Fonte: \\wsl.localhost\Ubuntu-22.04\root\olist-pipeline\mart\fato_itens_pbi.csv
// Colunas esperadas:
//   id_pedido  (text)  -> FK para fato_pedidos_pbi
//   id_produto (text)  -> FK para dim_produtos_pbi
//   preco      (Int64) -> preço do item
//   frete      (Int64) -> valor do frete do item
// Observações: manter nomes/tipos para relacionamentos no modelo.
// ---------------------------------------------


let
    Fonte = Csv.Document(File.Contents("\\wsl.localhost\Ubuntu-22.04\root\olist-pipeline\mart\fato_itens_pbi.csv"),[Delimiter=";", Columns=4, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Cabeçalhos Promovidos" = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Cabeçalhos Promovidos",{{"id_pedido", type text}, {"id_produto", type text}, {"preco", Int64.Type}, {"frete", Int64.Type}})
in
    #"Tipo Alterado"