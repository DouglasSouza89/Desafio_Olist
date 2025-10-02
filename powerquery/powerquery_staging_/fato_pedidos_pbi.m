// =================================================================================================
// Query: fato_pedidos_pbi
// Fonte: CSV (fato_pedidos_pbi.csv) — pipeline local (WSL / data lake local)
// Objetivo: Carregar a tabela fato de pedidos para o modelo e aplicar tipagem das colunas.
// Saída (esquema):
//   - id_pedido                        (text)
//   - customer_id                      (text)
//   - order_status                     (text)
//   - order_purchase_timestamp         (datetime)
//   - order_approved_at                (datetime)
//   - order_delivered_carrier_date     (datetime)
//   - order_delivered_customer_date    (datetime)
//   - order_estimated_delivery_date    (date)
//   - receita                          (number)
//   - id_meio_pagamento                (Int64)
// Passos principais:
//   1) Csv.Document  → leitura do arquivo
//   2) Table.PromoteHeaders → promover cabeçalhos
//   3) Table.TransformColumnTypes → tipagem conforme esquema acima
// Dependências/Parâmetros:
//   - Caminho de arquivo; recomenda-se usar parâmetro pRootPath/pFilePath para portabilidade.
// Observações:
//   - Garantir encoding correto e delimitador “,” conforme origem.
// Autor: Douglas Souza | Data: 2025-10-01 | Versão: 1.0
// =================================================================================================


let
    Fonte = Csv.Document(
        File.Contents("\\wsl.localhost\Ubuntu-22.04\root\olist-pipeline\mart\fato_pedidos_pbi.csv"),
        [Delimiter=";", Encoding=1252, QuoteStyle=QuoteStyle.None]
    ),
    #"Cabeçalhos Promovidos" = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Cabeçalhos Promovidos",{
        {"id_pedido", type text},
        {"customer_id", type text},
        {"order_status", type text},
        {"order_purchase_timestamp", type datetime},
        {"order_approved_at", type datetime},
        {"order_delivered_carrier_date", type datetime},
        {"order_delivered_customer_date", type datetime},
        {"order_estimated_delivery_date", type date},
        {"receita", type number},
        {"id_meio_pagamento", Int64.Type}
    })
in
    #"Tipo Alterado"