# Dicionário de Dados - Terraria

## Introdução

Este documento descreve o Dicionário de Dados do jogo Terraria, um jogo sandbox de ação e aventura. O objetivo deste dicionário é fornecer uma visão detalhada das estruturas de dados utilizadas no jogo, facilitando a compreensão do seu funcionamento interno, a manutenção do sistema, e a criação de novas funcionalidades.

O dicionário de dados é composto por uma série de tabelas, cada uma representando uma entidade dentro do jogo, como NPCs, itens, biomas, eventos, e muito mais. Cada tabela inclui uma descrição dos campos que ela contém, o tipo de dado de cada campo, o tamanho máximo permitido e quaisquer restrições de domínio aplicáveis.

Terraria é um jogo complexo, com muitos elementos interligados que contribuem para uma experiência de jogo rica e dinâmica. Este dicionário de dados visa capturar essa complexidade de uma forma estruturada e compreensível, servindo como uma referência útil para desenvolvedores, designers de jogos e qualquer outra pessoa interessada nos detalhes técnicos do jogo.

## Estrutura do Documento

O documento está organizado em seções, cada uma correspondente a uma tabela do banco de dados do jogo. Para cada tabela, são fornecidas as seguintes informações:

- **Nome**: O nome do campo na tabela.
- **Descrição**: Uma breve descrição do propósito do campo.
- **Tipo de Dado**: O tipo de dado armazenado no campo (e.g., Integer, String, Float).
- **Tamanho**: O tamanho máximo permitido para o campo (quando aplicável).
- **Restrições de Domínio**: Qualquer restrição aplicada ao campo, como chaves primárias (PK), chaves estrangeiras (FK) e valores não nulos.

Abaixo está a descrição detalhada de cada tabela e seus respectivos campos.

# Dicionário de Dados - Terraria

# Dicionário de Dados - Terraria

## Tabela: DIALOGO

| Nome        | Descrição               | Tipo de Dado | Tamanho | Restrições de Domínio           |
|-------------|--------------------------|--------------|---------|---------------------------------|
| ID_Dialogo  | Identificador único do diálogo | Integer      | -       | PK                              |
| texto       | Texto do diálogo        | Varchar      | 255     | Não nulo                        |

## Tabela: NPC

| Nome           | Descrição                 | Tipo de Dado | Tamanho | Restrições de Domínio           |
|----------------|----------------------------|--------------|---------|---------------------------------|
| ID_NPC         | Identificador único do NPC | Integer      | -       | PK                              |
| Tipo           | Tipo de NPC                | Varchar      | 50      | Não nulo                        |
| Comportamento  | Comportamento do NPC       | Varchar      | 255     | Não nulo                        |
| ID_Personagem  | Identificador do personagem| Integer      | -       | FK                              |
| ID_Dialogo     | Identificador do Diálogo   | Integer      | -       | FK                              |

## Tabela: PERSONAGEM

| Nome          | Descrição                   | Tipo de Dado | Tamanho | Restrições de Domínio           |
|---------------|------------------------------|--------------|---------|---------------------------------|
| ID_Personagem | Identificador único do personagem | Integer      | -       | PK                              |
| Nome          | Nome do personagem           | Varchar      | 255     | Não nulo                        |
| Posicao       | Posição do personagem no mapa| Varchar      | 100     | Não nulo                        |
| Vida          | Vida do personagem           | Integer      | -       | Não nulo                        |

## Tabela: BIOMA

| Nome         | Descrição                   | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|------------------------------|--------------|---------|---------------------------------|
| Nome         | Nome do bioma                | Varchar      | 255     | PK                              |
| Tipo         | Tipo de bioma                | Varchar      | 50      | Não nulo                        |

## Tabela: INSTANCIA_NPC

| Nome            | Descrição                   | Tipo de Dado | Tamanho | Restrições de Domínio           |
|-----------------|------------------------------|--------------|---------|---------------------------------|
| ID_Instancia_NPC | Identificador único da instância do NPC | Integer | - | PK                             |
| ID_NPC          | Identificador do NPC         | Integer      | -       | FK                             |
| VidaAtual       | Informa a vida atual do NPC  | Integer      | -       | Não nulo                        |
| Nome            | Nome do NPC                  | Varchar      | 255     | Não nulo                        |

## Tabela: PC

| Nome          | Descrição                   | Tipo de Dado | Tamanho | Restrições de Domínio           |
|---------------|------------------------------|--------------|---------|---------------------------------|
| ID_PC         | Identificador único do personagem jogável | Integer      | -       | PK                              |
| Mana          | Quantidade de mana do personagem jogável | Integer      | -       | Não nulo                        |
| ID_Personagem | Identificador do personagem  | Integer      | -       | FK                              |

## Tabela: INSTANCIA_PC

| Nome            | Descrição                   | Tipo de Dado | Tamanho | Restrições de Domínio           |
|-----------------|------------------------------|--------------|---------|---------------------------------|
| ID_Instancia_PC | Identificador único da instância do personagem jogável | Integer | - | PK                              |
| ID_PC           | Identificador do personagem jogável | Integer      | -       | FK                              |
| Vida_Atual      | Quantidade de vida do personagem jogável | Integer      | -       | Não nulo                        |
| Mana_Atual      | Quantidade de mana do personagem jogável | Integer      | -       | Não nulo                        |

## Tabela: MUNDO

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Mundo     | Identificador único do mundo  | Integer      | -       | PK                              |
| Nome         | Nome do mundo                 | Varchar      | 255     | Não nulo                        |
| Tamanho      | Tamanho do mundo              | Varchar      | 50      | Não nulo                        |
| Semente      | Semente do mundo              | Varchar      | 255     | Não nulo                        |
| Dificuldade  | Nível de dificuldade do mundo | Varchar      | 50      | Não nulo                        |
| Clima        | Clima do mundo                | Varchar      | 50      | Não nulo                        |
| Hora_do_dia  | Hora do dia no mundo          | Varchar      | 50      | Não nulo                        |

## Tabela: EVENTO

| Nome        | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|-------------|-------------------------------|--------------|---------|---------------------------------|
| Nome        | Nome do evento                | Varchar      | 255     | PK                              |
| Tipo        | Tipo de evento                | Varchar      | 50      | Não nulo                        |
| Data_Inicio | Data de início do evento      | Date         | -       | Não nulo                        |
| Data_Fim    | Data de término do evento     | Date         | -       | Não nulo                        |

## Tabela: INVENTARIO

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Inventario| Identificador único do inventário | Integer      | -       | PK                              |
| ID_Item      | Identificador do item         | Integer      | -       | FK                              |
| Quantidade   | Quantidade de itens no inventário | Integer      | -       | Não nulo                        |

## Tabela: ITEM

| Nome            | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|-----------------|-------------------------------|--------------|---------|---------------------------------|
| Nome            | Nome do item                  | Varchar      | 255     | PK                        |
| Tipo            | Tipo de item                  | Varchar      | 50      | Não nulo  |
| Acumulavel      | Informa se um item pode ser acumulado | Boolean      | -      | Não nulo  |

## Tabela: RECEITA

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Receita   | Identificador único da receita | Integer     | -       | PK                              |
| Nome         | Nome da receita               | Varchar      | 255     | Não nulo                        |
| Item_Final   | Identificador do item associado à receita | Integer | - | FK                              |
| Estacao_Bloco| Identificador do bloco associado à receita | Integer | - | FK                              |

## Tabela: CONSUMIVEL

| Nome     | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|----------|-------------------------------|--------------|---------|---------------------------------|
| Nome     | Identificador único do consumível | Varchar  | 255     | PK                              |
| ID_Item  | Identificador do item associado ao consumível | Integer | - | FK                              |

## Tabela: BUFF

| Nome        | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|-------------|-------------------------------|--------------|---------|---------------------------------|
| Nome        | Identificador único do consumível | Varchar  | 255     | PK                              |
| Efeito      | Efeito do consumível          | Varchar      | 255     | Não nulo                        |
| Duracao     | Duração do efeito do consumível | Integer   | -       | Não nulo                        |

## Tabela: ROUPA

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| Nome         | Identificador único da roupa  | Varchar      | 255     | PK                              |
| Defesa       | Quantidade de defesa fornecida pela roupa | Integer | - | Não nulo                        |
| Descricao    | Informações que podem ser úteis aos jogadores | Varchar | 255 | - |
| Aparencia    | Efeitos aplicados sobre a roupa | Boolean | - | Não nulo                        |
| Item_Nome    | Identificador do modificador associado à roupa | Integer | - | FK                              |

## Tabela: ACESSORIO

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| Nome         | Identificador único do acessório | Varchar  | 255     | PK                              |
| Efeito       | Efeito do acessório           | Varchar      | 255     | Não nulo                        |
| Item_Nome    | Identificador do item associado ao acessório | Varchar  | 255 | FK                              |
| Defesa       | Defesa aplicada ao acessório  | Integer      | -       | Não nulo                        |
| Descricao    | Informações que podem ser úteis aos jogadores | Varchar | 255 | -                              |

## Tabela: FERRAMENTA

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| Nome         | Identificador único da ferramenta | Varchar  | 255     | PK                              |
| Tipo         | Tipo de ferramenta            | Varchar      | 50      | Não nulo                        |
| Poder        | Poder da ferramenta           | Integer      | -       | Não nulo                        |
| Eficiencia   | Informações em relação à eficiência da ferramenta | Integer | - | Não nulo              |
| ChanceCrit   | Informações em relação à taxa de dano crítico da ferramenta | Integer | - | Não nulo              |
| Item_Nome    | Identificador do modificador associado à ferramenta | Varchar  | 255 | FK                             |

## Tabela: BLOCO

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| Nome         | Identificador único do bloco  | Varchar      | 255     | PK                              |
| Tipo         | Tipo de bloco                 | Varchar      | 50      | Não nulo                        |
| Item_Nome    | Identificador do item associado ao bloco | Varchar  | 255 | FK                              |

## Tabela: MODIFICADORES

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| Nome         | Identificador único do modificador | Varchar  | 255     | PK                              |
| Nome         | Nome do modificador           | Varchar      | 255     | Não nulo                        |



# Histórico de Versão

| Versão | Data       | Descrição                                     | Autor       |
|--------|------------|-----------------------------------------------|-------------|
| 1.0    | 2024-07-20 | Criação inicial do Dicionário de Dados         | [Euardo](https://github.com/edudsan)  |
| 1.1    | 2024-07-21 | Atualização do Dicionário de Dados            | [Euardo](https://github.com/edudsan)  |
