// ===================================================================
// Função: fxLoadCsv
// Finalidade: Ler CSV com cabeçalho e aplicar tipos de dados
// Autor: Douglas Souza | Data: 2025-10-01 | Versão: 1.0
// Depende: RootPath (query que retorna o caminho base)
// Uso: fxLoadCsv("fato_pedidos_pbi.csv", type table [id_pedido=text, ...])
// ===================================================================
let
    fxLoadCsv = (FileName as text, ColumnTypes as type) as table =>
    let
        Fonte     = Csv.Document(File.Contents(RootPath & FileName), [Delimiter=";", Encoding=1252, QuoteStyle=QuoteStyle.None]),
        Cabecalho = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
        Tipado    = Table.TransformColumnTypes(Cabecalho, ColumnTypes)
    in
        Tipado
in
    fxLoadCsv
