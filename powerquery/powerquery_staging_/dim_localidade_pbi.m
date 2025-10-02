// ==================================================================================================
// Query: dim_localidade_pbi
// Tipo: Staging (Dimensão Localidade / Geografia)
// Fonte: CSV (dim_localidade_pbi.csv) — ideal parametrizar o caminho (ex.: pRootPath/pDimLocalidade)
// Objetivo: Carregar e higienizar atributos de localidade para o modelo (cidade, UF, CEP, lat, lng).
// Esquema esperado (coluna → tipo):
//   id_local (text) | cep_prefixo (Int64.Type) | cidade (text) | uf (text) | lat (number) | lng (number)
// Passos do script:
//   1) Csv.Document                → leitura do arquivo
//   2) Table.PromoteHeaders        → promover cabeçalhos
//   3) Table.TransformColumnTypes  → tipagem conforme esquema
//   4) Text.Clean / Text.Trim      → limpeza de strings (remover caracteres invisíveis e espaços)
// Boas práticas:
//   - Garantir unicidade de id_local (remover duplicatas, se necessário).
//   - Validar latitude/longitude não nulas e faixas válidas (-90..90 / -180..180).
//   - Padronizar nomes de cidade/UF caso haja variações.
// Autor: Douglas Souza | Data: 2025-10-01 | Versão: 1.0
// ==================================================================================================

let
    Fonte = Csv.Document(File.Contents("\\wsl.localhost\Ubuntu-22.04\root\olist-pipeline\mart\dim_localidade_pbi.csv"),[Delimiter=";", Columns=6, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Cabeçalhos Promovidos" = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Cabeçalhos Promovidos",{{"id_local", type text}, {"cep_prefixo", Int64.Type}, {"cidade", type text}, {"uf", type text}, {"lat", type number}, {"lng", type number}}),
    #"Texto Limpo" = Table.TransformColumns(#"Tipo Alterado",{{"id_local", Text.Clean, type text}}),
    #"Texto Aparado" = Table.TransformColumns(#"Texto Limpo",{{"id_local", Text.Trim, type text}})
in
    #"Texto Aparado"