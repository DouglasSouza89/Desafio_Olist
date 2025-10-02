// ---------------------------------------------
// Consulta: dim_meio_pagamento_pbi
// Tabela destino: dim_meio_pagamento_pbi
// Autor: Douglas Souza | Data: 2025-10-01 | Versão: 1.0
// Descrição: Carrega a dimensão de meios de pagamento a partir do CSV,
//            promove cabeçalhos e define os tipos de dados.
// Campos-chave: id_meio_pagamento (Int64), tipo_pagamento (text)
// ---------------------------------------------

let
    Fonte = Csv.Document(File.Contents("\\wsl.localhost\Ubuntu-22.04\root\olist-pipeline\mart\dim_meio_pagamento_pbi.csv"),[Delimiter=";", Columns=2, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Cabeçalhos Promovidos" = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Cabeçalhos Promovidos",{{"id_meio_pagamento", Int64.Type}, {"tipo_pagamento", type text}})
in
    #"Tipo Alterado"