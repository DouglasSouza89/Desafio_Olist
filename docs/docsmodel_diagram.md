# Diagrama do Modelo (Mermaid)
> Autor: Douglas Souza · Data: 2025-10-06

> O diagrama abaixo usa Mermaid (renderizado nativamente no GitHub).

```mermaid
erDiagram
  DIM_CLIENTES ||--o{ FATO_PEDIDOS : "id_cliente"
  DIM_LOCALIDADE ||--o{ DIM_CLIENTES : "id_local"
  DIM_MEIO_PAGAMENTO ||--o{ FATO_PEDIDOS : "id_meio_pagamento"
  DIM_TEMPO ||--o{ FATO_PEDIDOS : "data_compra"
  DIM_TEMPO ||--o{ FATO_REVIEWS : "data_criacao_review"
  DIM_PRODUTOS ||--o{ FATO_ITENS : "id_produto"
  FATO_PEDIDOS ||--o{ FATO_ITENS : "id_pedido"
  FATO_PEDIDOS ||--o{ FATO_REVIEWS : "id_pedido"

  DIM_CLIENTES {
    text id_cliente PK
    text id_cliente_unico
    int  id_local FK
    int  cep_prefixo
  }

  DIM_LOCALIDADE {
    text id_local PK
    text cidade
    text uf
    number lat
    number lng
  }

  DIM_MEIO_PAGAMENTO {
    int id_meio_pagamento PK
    text tipo_pagamento
  }

  DIM_PRODUTOS {
    text id_produto PK
    text categoria_produto
    int  tam_nome
    int  tam_descricao
    int  qtde_fotos
    int  peso_g
  }

  DIM_TEMPO {
    date data PK
    int  id_tempo
    int  ano
    int  mes
    date mes_ano
    int  dia
    int  semana_iso
    int  tri
  }

  FATO_PEDIDOS {
    text id_pedido PK
    text customer_id FK
    date data_compra FK
    int  id_meio_pagamento FK
    text order_status
    number receita
  }

  FATO_ITENS {
    text id_pedido FK
    text id_produto FK
    number preco
    int  frete
  }

  FATO_REVIEWS {
    text id_review PK
    text id_pedido FK
    text id_cliente FK
    text id_produto FK
    int  nota_review
    datetime data_criacao_review FK
  }
