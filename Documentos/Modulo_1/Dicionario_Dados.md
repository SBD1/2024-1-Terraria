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

## Tabela: DIALOGO

| Nome        | Descrição               | Tipo de Dado | Tamanho | Restrições de Domínio           |
|-------------|--------------------------|--------------|---------|---------------------------------|
| ID_Dialogo  | Identificador único do diálogo | Integer      | -       | PK                              |
| texto       | Texto do diálogo        | String       | 255     | Não nulo                        |
| ID_NPC      | Identificador do NPC associado ao diálogo | Integer      | -       | FK                  |

## Tabela: NPC

| Nome           | Descrição                 | Tipo de Dado | Tamanho | Restrições de Domínio           |
|----------------|----------------------------|--------------|---------|---------------------------------|
| ID_NPC         | Identificador único do NPC | Integer      | -       | PK                              |
| Nome           | Nome do NPC                | String       | 255     | Não nulo                        |
| Tipo           | Tipo de NPC                | String       | 50      | vendedor, inimigo, aliado       |
| Vida           | Quantidade de vida do NPC  | Integer      | -       | Não nulo                        |
| Posição_X      | Coordenada X do NPC        | Float        | -       | Não nulo                        |
| Posição_Y      | Coordenada Y do NPC        | Float        | -       | Não nulo                        |
| Posição_Z      | Coordenada Z do NPC        | Float        | -       | Não nulo                        |
| Comportamento  | Comportamento do NPC       | String       | 255     | Não nulo                        |
| ID_Bioma       | Identificador do bioma     | Integer      | -       | FK (BIOMA.ID_Bioma)             |
| ID_Personagem  | Identificador do personagem| Integer      | -       | FK (PERSONAGEM.ID_Personagem)   |
| ID_Instancia_NPC | Identificador da instância do NPC | Integer | -   | FK                              |

## Tabela: PERSONAGEM

| Nome          | Descrição                   | Tipo de Dado | Tamanho | Restrições de Domínio           |
|---------------|------------------------------|--------------|---------|---------------------------------|
| ID_Personagem | Identificador único do personagem | Integer      | -       | PK                              |
| Nome          | Nome do personagem           | String       | 255     | Não nulo                        |
| Tipo          | Tipo de personagem           | String       | 50      | NPC, PC                         |
| Habilidades   | Habilidades do personagem    | String       | 255     | Não nulo                        |
| Nivel         | Nível do personagem          | Integer      | -       | Não nulo                        |

## Tabela: BIOMA

| Nome         | Descrição                   | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|------------------------------|--------------|---------|---------------------------------|
| ID_Bioma     | Identificador único do bioma | Integer      | -       | PK                              |
| Nome         | Nome do bioma                | String       | 255     | Não nulo                        |
| Tipo         | Tipo de bioma                | String       | 50      | terrestre, subterrâneo, etc.    |
| ID_Mundo     | Identificador do mundo       | Integer      | -       | FK                              |
| ID_Item      | Identificador do item        | Integer      | -       | FK                              |

## Tabela: INSTANCIA_NPC

| Nome         | Descrição                   | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|------------------------------|--------------|---------|---------------------------------|
| ID_Instancia_NPC | Identificador único da instância do NPC | Integer | - | PK                         |
| ID_NPC       | Identificador do NPC         | Integer      | -       | FK                             |
| ID_Item      | Identificador do item        | Integer      | -       | FK                             |

## Tabela: PC

| Nome          | Descrição                   | Tipo de Dado | Tamanho | Restrições de Domínio           |
|---------------|------------------------------|--------------|---------|---------------------------------|
| ID_PC         | Identificador único do personagem jogável | Integer      | -       | PK                              |
| Nome          | Nome do personagem jogável   | String       | 255     | Não nulo                        |
| Nivel         | Nível do personagem jogável  | Integer      | -       | Não nulo                        |
| Vida          | Quantidade de vida do personagem jogável | Integer      | -       | Não nulo                        |
| Mana          | Quantidade de mana do personagem jogável | Integer      | -       | Não nulo                        |
| ID_Usuario    | Identificador do usuário     | Integer      | -       | FK (USUARIO.ID_Usuario)         |
| ID_Instancia_PC | Identificador da instância do personagem jogável | Integer | - | FK  |
| ID_Personagem | Identificador do personagem  | Integer      | -       | FK    |

## Tabela: USUARIO

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Usuario   | Identificador único do usuário | Integer      | -       | PK                              |
| Nome         | Nome do usuário               | String       | 255     | Não nulo                        |
| Email        | Email do usuário              | String       | 255     | Não nulo, Único                 |
| Senha        | Senha do usuário              | String       | 255     | Não nulo                        |

## Tabela: INSTANCIA_PC

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Instancia_PC | Identificador único da instância do personagem jogável | Integer | - | PK                              |
| ID_PC        | Identificador do personagem jogável | Integer      | -       | FK (PC.ID_PC)                   |
| ID_Mundo     | Identificador do mundo        | Integer      | -       | FK              |
| ID_Inventario| Identificador do inventário   | Integer      | -       | FK    |

## Tabela: MUNDO

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Mundo     | Identificador único do mundo  | Integer      | -       | PK                              |
| Nome         | Nome do mundo                 | String       | 255     | Não nulo                        |
| Tamanho      | Tamanho do mundo              | String       | 50      | Pequeno, Médio, Grande          |
| Semente      | Semente do mundo              | String       | 255     | Não nulo                        |
| Dificuldade  | Nível de dificuldade do mundo | String       | 50      | Fácil, Normal, Difícil          |
| Clima        | Clima do mundo                | String       | 50      | Não nulo                        |
| Hora_do_dia  | Hora do dia no mundo          | String       | 50      | Não nulo                        |

## Tabela: EVENTO

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Evento    | Identificador único do evento | Integer      | -       | PK                              |
| Nome         | Nome do evento                | String       | 255     | Não nulo                        |
| Tipo         | Tipo de evento                | String       | 50      | Não nulo                        |
| Data_Inicio  | Data de início do evento      | Date         | -       | Não nulo                        |
| Data_Fim     | Data de término do evento     | Date         | -       | Não nulo                        |
| ID_Mundo     | Identificador do mundo        | Integer      | -       | FK                              |

## Tabela: INVENTARIO

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Inventario| Identificador único do inventário | Integer      | -       | PK                              |
| ID_Item      | Identificador do item         | Integer      | -       | FK                |
| Quantidade   | Quantidade de itens no inventário | Integer      | -       | Não nulo                        |

## Tabela: ITEM

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Item      | Identificador único do item   | Integer      | -       | PK                              |
| Nome         | Nome do item                  | String       | 255     | Não nulo
| Tipo         | Tipo de item                  | String       | 50      | Consumível, Roupa, Acessório, Ferramenta, Bloco |
| ID_Receita   | Identificador da receita associada ao item | Integer | - | FK          |
| ID_Inventario| Identificador do inventário associado ao item | Integer | - | FK    |
| ID_Instancia_PC | Identificador da instância do personagem jogável associado ao item | Integer | - | FK  |
| ID_Bioma     | Identificador do bioma associado ao item | Integer  | - | FK             |

## Tabela: RECEITA

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Receita   | Identificador único da receita | Integer     | -       | PK                              |
| Nome         | Nome da receita               | String      | 255     | Não nulo                        |
| ID_Item      | Identificador do item associado à receita | Integer | - | FK                |
| ID_Bloco     | Identificador do bloco associado à receita | Integer | - | FK              |

## Tabela: CONSUMIVEL

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Consumivel | Identificador único do consumível | Integer  | -       | PK                              |
| Efeito       | Efeito do consumível          | String      | 255     | Não nulo                        |
| Duracao      | Duração do efeito do consumível | Integer   | -       | Não nulo                        |
| ID_Item      | Identificador do item associado ao consumível | Integer | - | FK                |

## Tabela: ROUPA

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Roupa     | Identificador único da roupa  | Integer      | -       | PK                              |
| Defesa       | Quantidade de defesa fornecida pela roupa | Integer | - | Não nulo                        |
| ID_Item      | Identificador do item associado à roupa | Integer | - | FK                |
| ID_Modificador | Identificador do modificador associado à roupa | Integer | - | FK  |

## Tabela: ACESSORIO

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Acessorio | Identificador único do acessório | Integer   | -       | PK                              |
| Efeito       | Efeito do acessório           | String      | 255     | Não nulo                        |
| ID_Item      | Identificador do item associado ao acessório | Integer | - | FK               |
| ID_Modificador | Identificador do modificador associado ao acessório | Integer | - | FK  |

## Tabela: FERRAMENTA

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Ferramenta | Identificador único da ferramenta | Integer  | -       | PK                              |
| Tipo_Ferramenta | Tipo de ferramenta        | String      | 50      | Não nulo                        |
| Poder        | Poder da ferramenta          | Integer     | -       | Não nulo                        |
| ID_Item      | Identificador do item associado à ferramenta | Integer | - | FK               |
| ID_Modificador | Identificador do modificador associado à ferramenta | Integer | - | FK  |

## Tabela: BLOCO

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Bloco     | Identificador único do bloco  | Integer      | -       | PK                              |
| Tipo_Bloco   | Tipo de bloco                 | String       | 50      | Não nulo                        |
| ID_Item      | Identificador do item associado ao bloco | Integer | - | FK                |
| ID_Receita   | Identificador da receita associada ao bloco | Integer | - | FK         |

## Tabela: MODIFICADORES

| Nome         | Descrição                    | Tipo de Dado | Tamanho | Restrições de Domínio           |
|--------------|-------------------------------|--------------|---------|---------------------------------|
| ID_Modificador | Identificador único do modificador | Integer | -     | PK                              |
| Nome         | Nome do modificador           | String      | 255     | Não nulo                        |
| Efeito       | Efeito do modificador         | String      | 255     | Não nulo                        |
| ID_Roupa     | Identificador da roupa associada ao modificador | Integer | - | FK              |
| ID_Acessorio | Identificador do acessório associado ao modificador | Integer | - | FK      |
| ID_Ferramenta | Identificador da ferramenta associada ao modificador | Integer | - | FK    |

# Histórico de Versão

| Versão | Data       | Descrição                                     | Autor       |
|--------|------------|-----------------------------------------------|-------------|
| 1.0    | 2024-07-20 | Criação inicial do Dicionário de Dados         | [Euardo](https://github.com/edudsan)  |
