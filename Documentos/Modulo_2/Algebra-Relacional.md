# Algebra Relacional
A álgebra relacional é uma linguagem formal que fornece as bases teóricas para a manipulação de dados em bancos de dados relacionais. Ela opera sobre tabelas, conhecidas como relações/entidades, e permite realizar diversas operações para consultar e transformar os dados de maneira estruturada. 
Algumas das operações básicas incluem:
- Seleção: Filtra as linhas de uma tabela com base em uma condição, permitindo a extração de dados específicos.
- Projeção: Seleciona apenas determinadas colunas de uma tabela, eliminando as demais.
- União: Combina as linhas de duas tabelas que têm a mesma estrutura, removendo duplicatas.
- Interseção: Retorna apenas as linhas que são comuns a duas tabelas.
- Diferença: Retorna as linhas que estão em uma tabela, mas não na outra.
- Junção: Combina dados de duas ou mais tabelas com base em uma condição de correspondência.

Essas operações são fundamentais para a construção de consultas complexas e otimizadas em sistemas de gerenciamento de bancos de dados (SGBDs). A álgebra relacional é crucial para garantir a consistência e a precisão das operações realizadas sobre os dados, servindo como base para o SQL. Ela também ajuda a garantir que as consultas sejam executadas de maneira eficiente, o que é essencial para o desempenho de sistemas que lidam com grandes volumes de dados.

# Consultas

Segue a algebra relacional das principais consultas realizadas no projeto.

- **Listar todos os eventos que ocorrem em um determinado mundo:**
```
𝜋𝑁𝑜𝑚𝑒_𝐸𝑣𝑒𝑛𝑡𝑜←𝐸𝑣𝑒𝑛𝑡𝑜.𝑁𝑜𝑚𝑒,𝐸𝑣𝑒𝑛𝑡𝑜.𝑇𝑖𝑝𝑜,𝐸𝑣𝑒𝑛𝑡𝑜.𝐷𝑎𝑡𝑎_𝐼𝑛𝑖𝑐𝑖𝑜,𝐸𝑣𝑒𝑛𝑡𝑜.𝐷𝑎𝑡𝑎_𝐹𝑖𝑚,𝑁𝑜𝑚𝑒_𝑀𝑢𝑛𝑑𝑜←𝑀𝑢𝑛𝑑𝑜.𝑁𝑜𝑚𝑒(𝜎𝑀𝑢𝑛𝑑𝑜.𝑁𝑜𝑚𝑒=′𝑀𝑢𝑛𝑑𝑜𝑑𝑜𝐶𝑎𝑜𝑠′(𝜎Acontece.Evento_Nome = Evento.Nome(𝜎Acontece.ID_Mundo = Mundo.ID_Mundo(𝐴𝑐𝑜𝑛𝑡𝑒𝑐𝑒×𝐸𝑣𝑒𝑛𝑡𝑜×𝑀𝑢𝑛𝑑𝑜))))
```

- **Consultar todas as receitas que utilizam um determinado item:**
```
𝜋𝑟.𝐼𝐷_𝑅𝑒𝑐𝑒𝑖𝑡𝑎,𝑟.𝐼𝑡𝑒𝑚_𝐹𝑖𝑛𝑎𝑙,𝑟.𝐼𝑡𝑒𝑚_1,𝑟.𝑄𝑢𝑎𝑛𝑡𝑖𝑑𝑎𝑑𝑒_𝐼𝑡𝑒𝑚_1,𝑟.𝐼𝑡𝑒𝑚_2,𝑟.𝑄𝑢𝑎𝑛𝑡𝑖𝑑𝑎𝑑𝑒_𝐼𝑡𝑒𝑚_2,𝑟.𝐼𝑡𝑒𝑚_3,𝑟.𝑄𝑢𝑎𝑛𝑡𝑖𝑑𝑎𝑑𝑒_𝐼𝑡𝑒𝑚_3,𝑟.𝐸𝑠𝑡𝑎𝑐𝑎𝑜_𝐵𝑙𝑜𝑐𝑜(𝜎𝑟.𝐼𝑡𝑒𝑚_1=′𝐹𝑒𝑟𝑟𝑜′∨𝑟.𝐼𝑡𝑒𝑚_2=′𝐹𝑒𝑟𝑟𝑜′∨𝑟.𝐼𝑡𝑒𝑚_3=′𝐹𝑒𝑟𝑟𝑜′(ρr(𝑅𝑒𝑐𝑒𝑖𝑡𝑎)))
```

- **Listar todos os modificadores aplicados a uma ferramenta específica:**
```
𝜋𝑁𝑜𝑚𝑒_𝐹𝑒𝑟𝑟𝑎𝑚𝑒𝑛𝑡𝑎←𝐹𝑒𝑟𝑟𝑎𝑚𝑒𝑛𝑡𝑎.𝐼𝑡𝑒𝑚_𝑁𝑜𝑚𝑒,𝑁𝑜𝑚𝑒_𝑀𝑜𝑑𝑖𝑓𝑖𝑐𝑎𝑑𝑜𝑟←𝑀𝑜𝑑𝑖𝑓𝑖𝑐𝑎𝑑𝑜𝑟.𝑁𝑜𝑚𝑒,𝑀𝑜𝑑𝑖𝑓𝑖𝑐𝑎𝑑𝑜𝑟.𝐸𝑓𝑒𝑖𝑡𝑜(𝜎𝐹𝑒𝑟𝑟𝑎𝑚𝑒𝑛𝑡𝑎.𝐼𝑡𝑒𝑚_𝑁𝑜𝑚𝑒=′𝑃𝑖𝑐𝑎𝑟𝑒𝑡𝑎𝑑𝑒𝑂𝑢𝑟𝑜′(𝜎Ferramente_Tem.Ferramenta_Nome = Ferramenta.Item_Nome(𝜎Ferramente_Tem.Modificadores_Nome = Modificador.Nome((𝐹𝑒𝑟𝑟𝑎𝑚𝑒𝑛𝑡𝑎_𝑇𝑒𝑚×𝐹𝑒𝑟𝑟𝑎𝑚𝑒𝑛𝑡𝑎×𝑀𝑜𝑑𝑖𝑓𝑖𝑐𝑎𝑑𝑜𝑟)))))
```
- **Consultar todos os buffs fornecidos por um consumível específico:**
```
𝜋𝑁𝑜𝑚𝑒_𝐶𝑜𝑛𝑠𝑢𝑚𝑖𝑣𝑒𝑙←𝐶𝑜𝑛𝑠𝑢𝑚𝑖𝑣𝑒𝑙.𝐼𝑡𝑒𝑚_𝑁𝑜𝑚𝑒,𝑁𝑜𝑚𝑒_𝐵𝑢𝑓𝑓←𝐵𝑢𝑓𝑓.𝑁𝑜𝑚𝑒,𝐵𝑢𝑓𝑓.𝐷𝑢𝑟𝑎𝑐𝑎𝑜,𝐵𝑢𝑓𝑓.𝐸𝑓𝑒𝑖𝑡𝑜(𝜎𝐶𝑜𝑛𝑠𝑢𝑚𝑖𝑣𝑒𝑙.𝐼𝑡𝑒𝑚_𝑁𝑜𝑚𝑒=′𝑃𝑜𝑐𝑎𝑜𝑑𝑒𝑅𝑒𝑠𝑖𝑠𝑡𝑒𝑛𝑐𝑖𝑎𝑎𝑜𝐹𝑜𝑔𝑜′(𝜎Fornece.Consumivel_Nome = Consumivel.Item_Nome(𝜎Fornece.Buff_Nome = Buff.Nome(𝐹𝑜𝑟𝑛𝑒𝑐𝑒×𝐶𝑜𝑛𝑠𝑢𝑚𝑖𝑣𝑒𝑙×𝐵𝑢𝑓𝑓))))
```
- **Consulta todos os itens possuídos por cada um dos PCs existentes:**
```
𝜋𝑖𝑝𝑐.𝐼𝐷_𝑃𝐶,𝑖.Item←𝑁𝑜𝑚𝑒,𝑐.𝑄𝑢𝑎𝑛𝑡𝑖𝑑𝑎𝑑𝑒(𝜎𝑐.𝐼𝐷_𝐼𝑛𝑠𝑡𝑎𝑛𝑐𝑖𝑎_𝑃𝐶=𝑖𝑝𝑐.𝐼𝐷_𝐼𝑛𝑠𝑡𝑎𝑛𝑐𝑖𝑎_𝑃𝐶∧𝑐.𝐼𝑡𝑒𝑚_𝑁𝑜𝑚𝑒=𝑖.𝑁𝑜𝑚𝑒(γipc.ID_PC(ρc(𝐶𝑜𝑛𝑡𝑒𝑚)×ρipc(𝐼𝑛𝑠𝑡𝑎𝑛𝑐𝑖𝑎_𝑃𝐶)×ρi(𝐼𝑡𝑒𝑚))))
```

- **Consultar todos os detalhes dos NPCs, incluindo o diálogo associado:**
```
𝜋NPC.ID_NPC,Nome_Personagem←Personagem.Nome,NPC.Tipo,NPC.Comportamento,Dialogo_Associado←Dialogo.Texto(𝜎NPC.ID_Personagem = Personagem.ID_P(𝜎NPC.ID_Dialogo = Dialogo.ID_Dialogo(NPC x Personagem x Dialogo)))

```
- **Listar todos os itens que fazem parte de um determinado bioma:**
```
ρ(Nome_Item,Nome_Bioma,Tipo_Bioma(𝜋Item.Nome,Bioma.Nome,Bioma.Tipo(𝜎Faz_Parte_Bioma.Item_Nome = Item.Nome(𝜎Faz_Parte_Biom.Bioma_Nome = Bioma.Nome(𝜎Bioma.Nome = 'Floresta'(Faz_Parte_Bioma x Item x Bioma))))))
```
- **Consultar todos os personagens e suas posições no mundo:**
```
𝜋Nome_Personagem←Personagem.Nome,Nome_Mundo←Mundo.Nome,Posicao.X,Posicao.Y(𝜎Posicao.ID_Personagem = Personagem.ID_P(𝜎Posicao.ID_Mundo = Mundo.ID_Mundo( Posicao x Personagem x Mundo)))
```



| Versão | Data       | Descrição                                     | Autor       |
|--------|------------|-----------------------------------------------|-------------|
| 1.0    | 2024-08-19 | Criação do Documento e adição da Algebra Relacional       | [Thiago](https://github.com/Thiab394)  |