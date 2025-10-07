
---

## 2) `docs/data_dictionary.md` (dicionário de dados)

> Copie tudo abaixo e cole no arquivo `docs/data_dictionary.md`.

```markdown
# Dicionário de Dados

> Descrição dos principais campos por tabela. Tipos seguem o modelo após o ETL (Power Query).

---

## Fatos

### `fato_pedidos_pbi`
| Coluna                        | Tipo       | Descrição                                                     | Exemplo                         |
|------------------------------|-----------|----------------------------------------------------------------|---------------------------------|
| `id_pedido` (PK)             | text      | Identificador do pedido                                        | `e481f51cbdc54678b7cc49136f2d6af7` |
| `customer_id`                | text      | Identificador do cliente (nativo Olist)                        | `9ef432eb6251297304e76186b10a928d` |
| `order_status`               | text      | Status do pedido                                               | `delivered`                     |
| `order_purchase_timestamp`   | datetime  | Data/hora da compra                                            | `2017-07-28 10:20:00`           |
| `order_approved_at`          | datetime  | Data/hora de aprovação                                         | `2017-07-28 11:00:00`           |
| `order_delivered_carrier_date` | datetime| Coleta pela transportadora                                     | `2017-07-29 08:10:00`           |
| `order_delivered_customer_date`| datetime| Entrega ao cliente                                             | `2017-08-03 12:45:00`           |
| `order_estimated_delivery_date`| date    | Data estimada de entrega                                       | `2017-08-05`                    |
| `receita`                    | number    | Valor pago (base do Ticket Médio)                              | `159.33`                        |
| `id_meio_pagamento` (FK)     | int       | Chave para `dim_meio_pagamento_pbi`                            | `1`                             |
| `data_compra` (FK)           | date      | Data da compra (para ligar na `dim_tempo_pbi`)                 | `2017-07-28`                    |
| `id_cliente` (FK)            | text      | Cliente do pedido (para `dim_clientes_pbi`)                    | `8ceb3051...`                   |

### `fato_itens_pbi`
| Coluna        | Tipo  | Descrição                               | Exemplo  |
|---------------|-------|------------------------------------------|----------|
| `id_pedido`   | text  | FK para pedido                           | `...af7` |
| `id_produto`  | text  | FK para produto                          | `...3b1` |
| `preco`       | int   | Preço do item                            | `120`    |
| `frete`       | int   | Valor do frete                           | `19`     |

### `fato_reviews`
| Coluna               | Tipo     | Descrição                          | Exemplo       |
|---------------------|----------|------------------------------------|---------------|
| `id_review` (PK)    | text     | Identificador da review            | `R123...`     |
| `id_pedido` (FK)    | text     | FK para pedido                     | `...af7`      |
| `id_cliente`        | text     | Cliente que avaliou                | `...928d`     |
| `id_produto` (FK)   | text     | Produto avaliado                   | `...3b1`      |
| `nota_review`       | int      | Nota (1 a 5)                       | `5`           |
| `data_criacao_review` | datetime | Data/hora da review               | `2017-08-04`  |

---

## Dimensões

### `dim_clientes_pbi`
| Coluna             | Tipo  | Descrição                              |
|--------------------|-------|----------------------------------------|
| `id_cliente` (PK)  | text  | Identificador do cliente               |
| `id_cliente_unico` | text  | Chave “global” do cliente              |
| `id_local` (FK)    | int   | Localidade do cliente                  |
| `cep_prefixo`      | int   | Prefixo de CEP                         |

### `dim_localidade_pbi`
| Coluna        | Tipo  | Descrição                        |
|---------------|-------|----------------------------------|
| `id_local`(PK)| text  | Identificador da localidade      |
| `cep_prefixo` | int   | Prefixo de CEP                   |
| `cidade`      | text  | Cidade                           |
| `uf`          | text  | Unidade Federativa               |
| `lat`         | float | Latitude                         |
| `lng`         | float | Longitude                        |

### `dim_produtos_pbi`
| Coluna             | Tipo | Descrição                                |
|--------------------|------|------------------------------------------|
| `id_produto` (PK)  | text | Identificador do produto                 |
| `categoria_produto`| text | Categoria do produto                     |
| `tam_nome`         | int  | Tamanho do nome do produto               |
| `tam_descricao`    | int  | Tamanho da descrição                     |
| `qtde_fotos`       | int  | Quantidade de fotos                      |
| `peso_g`           | int  | Peso em gramas                           |

### `dim_tempo_pbi`
| Coluna      | Tipo   | Descrição                       |
|-------------|--------|---------------------------------|
| `data` (PK) | date   | Data calendário                 |
| `id_tempo`  | int    | Chave técnica                   |
| `ano`       | int    | Ano                             |
| `mes`       | int    | Mês                             |
| `mes_ano`   | date   | Primeiro dia do mês             |
| `dia`       | int    | Dia do mês                      |
| `semana_iso`| int    | Semana ISO                      |
| `trimestre` | int    | Trimestre                       |

### `dim_meio_pagamento_pbi`
| Coluna               | Tipo | Descrição             |
|----------------------|------|-----------------------|
| `id_meio_pagamento` (PK) | int  | Chave do meio de pagamento |
| `tipo_pagamento`     | text | Ex.: cartão, boleto   |

---

> **Observações**
> - Tipos são pós-ETL. Se divergirem do seu modelo final, ajuste aqui para manter alinhado.
> - Campos adicionais podem ser incluídos conforme evolução do projeto.
