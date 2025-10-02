// ==================================================================================================
// Query: dim_produtos_pbi
// Tipo: Staging (dimensão de produtos)
// Fonte: CSV (dim_produtos_pbi.csv) — caminho parametrizável (ex.: pRootPath/pProdutos)
// Objetivo: Carregar o catálogo de produtos e tipar as colunas para uso no modelo estrela.
// Esquema esperado (principais colunas):
//   - id_produto          (text)        — chave da dimensão
//   - categoria_produto   (text)        — categoria / família
//   - tam_nome            (Int64.Type)  — tamanho do nome
//   - tam_descricao       (Int64.Type)  — tamanho da descrição
//   - qtde_fotos          (Int64.Type)  — quantidade de fotos
//   - peso_g              (Int64.Type)  — peso em gramas
//   - altura_cm           (Int64.Type)  — altura em cm
//   - largura_cm          (Int64.Type)  — largura em cm
//   - comprimento_cm      (Int64.Type)  — comprimento em cm
// Passos do script:
//   1) Csv.Document                  → leitura do arquivo
//   2) Table.PromoteHeaders          → promover cabeçalhos
//   3) Table.TransformColumnTypes    → tipagem de dados conforme esquema acima
// Observações:
//   - Prefira parâmetros para o caminho do arquivo para portabilidade.
//   - Se houver nulos nas medidas (peso/altura/largura/comprimento), considerar substituição ou auditoria.
//   - Garantir que id_produto não tenha duplicatas na camada de modelagem.
// Autor: Douglas Souza | Data: 2025-10-01 | Versão: 1.0
// ==================================================================================================


let
    Fonte = Csv.Document(File.Contents("\\wsl.localhost\Ubuntu-22.04\root\olist-pipeline\mart\dim_produtos_pbi.csv"),[Delimiter=";", Columns=9, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Cabeçalhos Promovidos" = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Cabeçalhos Promovidos",{{"id_produto", type text}, {"categoria_produto", type text}, {"tam_nome", Int64.Type}, {"tam_descricao", Int64.Type}, {"qtde_fotos", Int64.Type}, {"peso_g", Int64.Type}, {"comp_cm", Int64.Type}, {"alt_cm", Int64.Type}, {"larg_cm", Int64.Type}})
in
    #"Tipo Alterado"