// ==================================================================================================
// Query: dim_tempo_pbi
// Tipo: Staging (Dimensão Calendário/Tempo)
// Fonte: CSV (dim_tempo_pbi.csv) — ideal usar parâmetro de caminho (ex.: pRootPath/pTempo)
// Objetivo: Carregar a dimensão de tempo para o modelo estrela, com chaves e atributos de calendário.
// Esquema esperado (principais colunas):
//   - data        (date)       — data no formato Date
//   - id_tempo    (Int64.Type) — chave surrogate (ex.: AAAAMMDD)
//   - ano         (Int64.Type) — ano numérico
//   - mes         (Int64.Type) — mês numérico (1–12)
//   - mes_ano     (date)       — data “primeiro dia do mês” (ou marcador de mês)
//   - dia         (Int64.Type) — dia do mês
//   - semana_iso  (Int64.Type) — semana ISO
//   - trimestre   (Int64.Type) — trimestre (1–4)   // se existir na base
// Passos do script:
//   1) Csv.Document                  → leitura do arquivo
//   2) Table.PromoteHeaders          → promover cabeçalhos
//   3) Table.TransformColumnTypes    → tipagem de dados conforme esquema acima
// Boas práticas / Observações:
//   - Garanta unicidade de id_tempo (sem duplicatas).
//   - Verifique se o intervalo de datas cobre todo o período do fato.
//   - Caso use feriados, mantenha tabela auxiliar (dim_feriados) e relacione via [data].
// Autor: Douglas Souza | Data: 2025-10-01 | Versão: 1.0
// ==================================================================================================

let
    Fonte = Csv.Document(File.Contents("\\wsl.localhost\Ubuntu-22.04\root\olist-pipeline\mart\dim_tempo_pbi.csv"),[Delimiter=";", Columns=8, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Cabeçalhos Promovidos" = Table.PromoteHeaders(Fonte, [PromoteAllScalars=true]),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Cabeçalhos Promovidos",{{"data", type date}, {"id_tempo", Int64.Type}, {"ano", Int64.Type}, {"mes", Int64.Type}, {"mes_ano", type date}, {"dia", Int64.Type}, {"semana_iso", Int64.Type}, {"trimestre", Int64.Type}})
in
    #"Tipo Alterado"