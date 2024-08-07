# Modelo Entidade-Relacionamento (MER) do Terraria

Este repositório contém o Modelo Entidade-Relacionamento (MER) para o jogo de texto tipo RPG baseado no Terraria. O MER é uma representação visual e lógica das estruturas de dados do jogo, detalhando como as diferentes entidades se relacionam e interagem entre si. Este modelo serve como uma base fundamental para o desenvolvimento do banco de dados e a implementação de funcionalidades no jogo.

## Objetivo
O objetivo deste MER é proporcionar uma visão clara e organizada das entidades principais do jogo, seus atributos, e os relacionamentos entre elas. Com isso, buscamos garantir a integridade, consistência e eficiência no gerenciamento dos dados ao longo do desenvolvimento do jogo.

## 1. Entidades
- Dialogo
- NPC
- Personagem
- Posicao
- Bioma
- Instancia_NPC
- PC
- Instancia_PC
- Mundo
- Evento
- Item
- Receita
- Consumível
- Buff
- Roupa
- Acessorio
- Ferramenta
- Bloco
- Modificador
  
## 2. Atributos

- **Dialogo:** <ins>ID_Dialogo</ins>, Texto;
- **NPC:** <ins>ID_NPC</ins>, Tipo, Comportamento, ID_Personagem (FK), ID_Dialogo (FK);
- **Personagem:** <ins>ID_Personagem</ins>, Nome, Vida;
- **Posicao:** <ins>ID_Personagem</ins>, <ins>ID_Mundo</ins>, X, Y;
- **Bioma:** <ins>Nome</ins>, Tipo;
- **Instancia_NPC:** <ins>ID_Instancia_NPC</ins>, ID_NPC (FK), VidaAtual, Nome;
- **PC:** <ins>ID_PC</ins>, Mana, ID_Personagem (FK);
- **Instancia_PC:** <ins>ID_Instancia_PC</ins>, ID_PC (FK), Vida_Atual, Mana_Atual;
- **Mundo:** <ins>ID_Mundo</ins>, Nome, Tamanho, Semente, Dificuldade, Clima, Hora_do_dia;
- **Evento:** <ins>Nome</ins>, Tipo, Data_Inicio, Data_Fim;
- **Item:** <ins>Nome</ins>, Tipo, Acumulavel;
- **Receita:** <ins>ID_Receita</ins>, Item_Final (FK), Estacao_Bloco (FK);
- **Consumivel:** <ins>Item_Nome</ins>;
- **Buff:** <ins>Nome</ins>, Efeito, Duracao;
- **Roupa:** <ins>Item_Nome</ins>, Defesa, Descricao, Aparencia;
- **Acessorio:** <ins>Item_Nome</ins>, Efeito, Defesa, Descricao;
- **Ferramenta:** <ins>Item_Nome</ins>, Tipo, Poder, Eficiencia, ChanceCrit;
- **Bloco:** <ins>Item_Nome</ins>, Tipo;
- **Modificador:** <ins>Nome</ins>, Efeito;

## 3. Relacionamentos

1. **Personagem - Posição**
   - Um personagem pode ter várias posições, mas cada posição pertence a um único personagem.
   - Cardinalidade: 1:N

2. **Mundo - Posição**
   - Um mundo pode ter várias posições, mas cada posição pertence a um único mundo.
   - Cardinalidade: 1:N

3. **Personagem - NPC**
   - Um personagem pode ter vários NPCs associados, mas cada NPC pertence a um único personagem.
   - Cardinalidade: 1:N

4. **Diálogo - NPC**
   - Um diálogo pode ser associado a vários NPCs, mas cada NPC tem apenas um diálogo associado.
   - Cardinalidade: 1:N

5. **Personagem - PC**
   - Um personagem pode ter vários PCs associados, mas cada PC pertence a um único personagem.
   - Cardinalidade: 1:N

6. **PC - Instância_PC**
   - Um PC pode ter várias instâncias, mas cada instância de PC pertence a um único PC.
   - Cardinalidade: 1:N

7. **NPC - Instância_NPC**
   - Um NPC pode ter várias instâncias, mas cada instância de NPC pertence a um único NPC.
   - Cardinalidade: 1:N

8. **Item - Receita**
   - Um item pode ser associado a várias receitas, mas cada receita é associada a um único item.
   - Cardinalidade: 1:N

9. **Bloco - Receita**
   - Um bloco pode ser associado a várias receitas, mas cada receita é associada a um único bloco.
   - Cardinalidade: 1:N

10. **Item - Consumível**
    - Um item pode ser associado a um único consumível, mas cada consumível é associado a um único item.
    - Cardinalidade: 1:1

11. **Item - Roupa**
    - Um item pode ser associado a uma única roupa, mas cada roupa é associada a um único item.
    - Cardinalidade: 1:1

12. **Item - Acessório**
    - Um item pode ser associado a um único acessório, mas cada acessório é associado a um único item.
    - Cardinalidade: 1:1

13. **Item - Ferramenta**
    - Um item pode ser associado a uma única ferramenta, mas cada ferramenta é associada a um único item.
    - Cardinalidade: 1:1

14. **Item - Bloco**
    - Um item pode ser associado a um único bloco, mas cada bloco é associado a um único item.
    - Cardinalidade: 1:1

   # Histórico de Versão

| Versão | Data       | Descrição                                     | Autor       |
|--------|------------|-----------------------------------------------|-------------|
| 1.0    | 2024-07-22 | Criação inicial do MER        | [Euardo](https://github.com/edudsan), [AGoretti](https://github.com/AGoretti), [Thiago](https://github.com/Thiab394)|
