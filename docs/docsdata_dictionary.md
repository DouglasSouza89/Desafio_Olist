# Dicionário de Dados — Desafio Olist
> Autor: Douglas Souza · Data: 2025-10-06

Este dicionário resume os campos das tabelas do modelo (fatos e dimensões), com tipos, chaves e observações.

## Convenções
- **PK**: chave primária · **FK**: chave estrangeira  
- Tipos: `text`, `int64`, `number`, `date`, `datetime`

---

## Fatos

### `fato_pedidos_pbi`
| Campo                | Tipo     | Chave | Descrição                                                  | Origem/Regra |
|----------------------|----------|-------|------------------------------------------------------------|--------------|
| `id_pedido`          | text     | PK    | Identificador do pedido                                    | CSV `fato_pedidos_pbi.csv` |
| `customer_id`        | text     | FK    | Cliente do pedido (liga em `dim_clientes_pbi[id_cliente]`) | CSV |
| `data_compra`        | date     | FK    | Data da compra (liga em `dim_tempo_pbi[data]`)             | CSV |
| `id_meio_pagamento`  | int64    | FK    | Meio de pagamento (liga em `dim_meio_pagamento_pbi`)       | CSV |
| `order_status`       | text     | —     | Status do pedido                                           | CSV |
| `receita`            | number   | —     | Valor financeiro (base p/ Ticket Médio)                    | CSV |

### `fato_itens_pbi`
| Campo       | Tipo   | Chave | Descrição                                             | Origem/Regra |
|-------------|--------|-------|-------------------------------------------------------|--------------|
| `id_pedido` | text   | FK    | Liga em `fato_pedidos_pbi[id_pedido]`                 | CSV |
| `id_produto`| text   | FK    | Liga em `dim_produtos_pbi[id_produto]`                | CSV |
| `preco`     | number | —     | Preço do item                                         | CSV |
| `frete`     | int64  | —     | Custo de frete (por item)                             | CSV |

### `fato_reviews`
| Campo               | Tipo     | Chave | Descrição                                             | Origem/Regra |
|---------------------|----------|-------|-------------------------------------------------------|--------------|
| `id_review`         | text     | PK    | Identificador da avaliação                            | CSV |
| `id_pedido`         | text     | FK    | Liga em `fato_pedidos_pbi[id_pedido]`                 | CSV |
| `id_cliente`        | text     | FK    | Liga em `dim_clientes_pbi[id_cliente]`                | CSV |
| `id_produto`        | text     | FK    | Liga em `dim_produtos_pbi[id_produto]`                | CSV |
| `nota_review`       | int64    | —     | Nota da avaliação                                     | CSV |
| `data_criacao_review` | datetime | FK  | Liga em `dim_tempo_pbi[data]`                         | CSV |

---

## Dimensões

### `dim_clientes_pbi`
| Campo             | Tipo   | Chave | Descrição                                   | Origem/Regra |
|-------------------|--------|-------|---------------------------------------------|--------------|
| `id_cliente`      | text   | PK    | Cliente (natural)                           | CSV |
| `id_cliente_unico`| text   | —     | Derivado/normalizado                        | CSV |
| `id_local`        | int64  | FK    | Liga em `dim_localidade_pbi[id_local]`      | CSV |
| `cep_prefixo`     | int64  | —     | Prefixo do CEP                              | CSV |

### `dim_localidade_pbi`
| Campo     | Tipo   | Chave | Descrição                 | Origem/Regra |
|-----------|--------|-------|---------------------------|--------------|
| `id_local`| text   | PK    | Localidade (código)       | CSV |
| `cidade`  | text   | —     | Cidade                    | CSV |
| `uf`      | text   | —     | Unidade da Federação      | CSV |
| `lat`     | number | —     | Latitude                  | CSV |
| `lng`     | number | —     | Longitude                 | CSV |

### `dim_meio_pagamento_pbi`
| Campo              | Tipo  | Chave | Descrição            | Origem/Regra |
|--------------------|-------|-------|----------------------|--------------|
| `id_meio_pagamento`| int64 | PK    | Código do meio       | CSV |
| `tipo_pagamento`   | text  | —     | Descrição do meio    | CSV |

### `dim_produtos_pbi`
| Campo             | Tipo  | Chave | Descrição                       | Origem/Regra |
|-------------------|-------|-------|----------------------------------|--------------|
| `id_produto`      | text  | PK    | Produto                          | CSV |
| `categoria_produto`| text | —     | Categoria                        | CSV |
| `tam_nome`        | int64 | —     | Tamanho do nome do produto       | CSV |
| `tam_descricao`   | int64 | —     | Tamanho da descrição             | CSV |
| `qtde_fotos`      | int64 | —     | Quantidade de fotos              | CSV |
| `peso_g`          | int64 | —     | Peso em gramas                   | CSV |

### `dim_tempo_pbi`
| Campo     | Tipo | Chave | Descrição                         | Origem/Regra |
|-----------|------|-------|-----------------------------------|--------------|
| `data`    | date | PK    | Data (chave)                      | CSV |
| `id_tempo`| int64| —     | Id técnico                        | CSV |
| `ano`     | int64| —     | Ano                               | CSV |
| `mes`     | int64| —     | Mês número                        | CSV |
| `mes_ano` | date | —     | Primeiro dia do mês (conveniência)| CSV |
| `dia`     | int64| —     | Dia do mês                        | CSV |
| `semana_iso`| int64| —   | Semana ISO                        | CSV |
| `tri`     | int64| —     | Trimestre                         | CSV |

> **Atualize/complete** a tabela conforme evoluir o modelo.
