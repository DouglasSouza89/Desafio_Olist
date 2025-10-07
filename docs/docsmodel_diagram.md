# Diagrama do Modelo (estrela)

> Visão lógica do modelo analítico (fatos x dimensões).

```mermaid
erDiagram
  DIM_CLIENTES {
    text id_cliente PK
    text id_cliente_unico
    int  id_local FK
    int  cep_prefixo
  }

  DIM_LOCALIDADE {
    text id_local PK
    int  cep_prefixo
    text cidade
    text uf
    float lat
    float lng
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
    int  trimestre
  }

  DIM_MEIO_PAGAMENTO {
    int  id_meio_pagamento PK
    text tipo_pagamento
  }

  FATO_PEDIDOS {
    text  id_pedido PK
    text  customer_id
    text  order_status
    datetime order_purchase_timestamp
    datetime order_approved_at
    datetime order_delivered_carrier_date
    datetime order_delivered_customer_date
    date  order_estimated_delivery_date
    number receita
    int   id_meio_pagamento FK
    date  data_compra FK
    text  id_cliente FK
  }

  FATO_ITENS {
    text id_pedido FK
    text id_produto FK
    int  preco
    int  frete
  }

  FATO_REVIEWS {
    text id_review PK
    text id_pedido FK
    text id_cliente
    text id_produto FK
    int  nota_review
    datetime data_criacao_review
  }

  %% Relações (cardinalidades)
  DIM_CLIENTES ||--o{ FATO_PEDIDOS : "id_cliente"
  DIM_LOCALIDADE ||--o{ DIM_CLIENTES : "id_local"
  DIM_MEIO_PAGAMENTO ||--o{ FATO_PEDIDOS : "id_meio_pagamento"
  DIM_TEMPO ||--o{ FATO_PEDIDOS : "data_compra = data"
  FATO_PEDIDOS ||--o{ FATO_ITENS : "id_pedido"
  FATO_PEDIDOS ||--o{ FATO_REVIEWS : "id_pedido"
  DIM_PRODUTOS ||--o{ FATO_ITENS : "id_produto"
  DIM_PRODUTOS ||--o{ FATO_REVIEWS : "id_produto"
