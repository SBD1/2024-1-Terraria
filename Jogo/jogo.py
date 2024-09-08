from database import *
import cmd
import sys
import os
import time
import random
import psycopg2

connection = create_connection()

try:
    cur = connection.cursor()
except psycopg2.OperationalError:
    print("erro")
    pass

screen_width = 100
cur.execute('SELECT x, y from posicao where id_personagem = 1')
teste = cur.fetchall()

class player:
    def __init__(self):
        self.name = ''
        self.job = ''
        self.hp = 0
        self.mp = 0
        self.status_effects = []
        self.location =  str(teste[0][0]) + str(teste[0][1])
        self.game_over = False
myPlayer = player()

global ID_PC
ID_M = None


##### Title Screen #####
def title_screen_selections():
    option = input("> ")
    if option.lower() == ("play"):
        setup_game() # placeholder until written
    elif option. lower() == ("help"):
        help_menu()
    elif option. lower() == ("quit"):
        sys.exit()
    while option.lower() not in ['play', 'help', 'quit']:
        print("Please enter a valid command.")
        option = input("> ")
        if option.lower() == ("play"):
            setup_game() # placeholder until written
        elif option. lower() == ("help"):
            help_menu()
        elif option. lower() == ("quit"):
            sys.exit()

def title_screen():
    #os.system('clear')
    print('############################')
    print('# Welcome to the Text Terraria! #')
    print('############################')
    print('- Play -')
    print('- Help -')
    print('- Quit -')

    title_screen_selections()
    
def help_menu():
    print('# Welcome to the Text Terraria!') 
    print('############################')
    print('- Use up, down, left, right to move') 
    print('-Type your commands to do them') 
    print('Use "look" to inspect something') 
    print('Good luck and have fun!') 
    title_screen_selections()


ZONENAME = ''
DESCRIPTION = 'description'
EXAMINATION = "examine"
SOLVED = False
UP = 'up', 'north'
DOWN = 'down', 'south' 
LEFT ='left', 'west' 
RIGHT ='right', 'east'

solved_places = {'11': False, '12': False, '13': False, '14': False,
                 '21': False, '22': False, '23': False, '24': False,
                 '31': False, '32': False, '33': False, '34': False,
                 '41': False, '42': False, '43': False, '44': False}

zonemap = {
    '11': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '',
        DOWN: '21', 
        LEFT: '' ,
        RIGHT: '12'
    },
    '12': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '',
        DOWN: '22', 
        LEFT: '11' ,
        RIGHT: '13'
    },    
    '13': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '',
        DOWN: '23', 
        LEFT: '12' ,
        RIGHT: '14'
    },    
    '14': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '',
        DOWN: '24', 
        LEFT: '13' ,
        RIGHT: ''
    }, 
    '21': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '11',
        DOWN: '31', 
        LEFT: '' ,
        RIGHT: '22'
    },
    '22': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '12',
        DOWN: '32', 
        LEFT: '21' ,
        RIGHT: '23'
    },    
    '23': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '13',
        DOWN: '33', 
        LEFT: '22' ,
        RIGHT: '24'
    },    
    '24': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '14',
        DOWN: '34', 
        LEFT: '23' ,
        RIGHT: ''
    },
    '31': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '21',
        DOWN: '41', 
        LEFT: '' ,
        RIGHT: '32'
    },
    '32': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '22',
        DOWN: '42', 
        LEFT: '31' ,
        RIGHT: '33'
    },    
    '33': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '23',
        DOWN: '43', 
        LEFT: '32' ,
        RIGHT: '34'
    },    
    '34': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '24',
        DOWN: '44', 
        LEFT: '33' ,
        RIGHT: ''
    },
    '41': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '31',
        DOWN: '', 
        LEFT: '' ,
        RIGHT: '42'
    },
    '42': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '32',
        DOWN: '', 
        LEFT: '41' ,
        RIGHT: '43'
    },    
    '43': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '33',
        DOWN: '', 
        LEFT: '42' ,
        RIGHT: '43'
    },    
    '44': {
        ZONENAME: 'Hall',
        DESCRIPTION: 'description',
        EXAMINATION: "examine",
        SOLVED: False,
        UP: '34',
        DOWN: '', 
        LEFT: '43' ,
        RIGHT: ''
    },                

}

def print_location():
    print('#' + myPlayer. location.upper() + '#')
    print('#' + zonemap [myPlayer.location] [DESCRIPTION] + '#')


def prompt():
    print("\n" + "===============================")
    print("What would you like to do?")
    action = input(">")
    acceptable_actions = ['move', 'go', 'travel', 'walk', 'quit', 'examine', 'inspect', 'interact', 'look']
    while action.lower() not in acceptable_actions:
        print("Unknown action, try again.\n")
        action = input(">")
    if action.lower() == 'quit':
        sys.exit()
    elif action.lower() in ['move', 'go', 'travel', 'walk']:
        player_move(action.lower())
    elif action. lower() in ['examine', 'inspect', 'interact', 'look']:
        print('Desenvolvimento')


def player_move(myAction):
    ask= "Where would you like to move to?\n"
    dest = input (ask)
    if dest in ['up', 'north']:
        destination = zonemap [myPlayer. location] [UP]
        movement_handler(destination)
    elif dest in ['left', 'west']:
        destination = zonemap [myPlayer. location] [LEFT]
        movement_handler(destination)
    elif dest in ['east', 'right']:
        destination = zonemap [myPlayer. location] [RIGHT]
        movement_handler(destination)
    elif dest in ['south', 'down']:
        destination = zonemap [myPlayer. location] [DOWN]
        movement_handler(destination)

def movement_handler(destination):
    encontro = ''
    if destination == "":
        print("Cant go any futher in this direction!")
    else:
        print("\n" + "You have moved to the " + destination + ".")
        myPlayer. location = destination
        x = int(destination[0])
        y = int(destination[1])
        print(x, y)

        '''
        Tratamentos Encontros:
        if x == 1:
            sala = 'a' + str(y)
            cur.execute("SELECT (%s) FROM Instancia_Mundo where ID_PC = (%s);", sala, ID_PC)
            encontro = cur.fetchall()
            if encontro:
                encotro_handler(encontro)
        if x == 2:
            sala = 'b' + str(y)
            cur.execute("SELECT (%s) FROM Instancia_Mundo where ID_PC = (%s);", sala, ID_PC)
            encontro = cur.fetchall()
            if encontro:
                encotro_handler(encontro)
        if x == 3:
            sala = 'c' + str(y)
            cur.execute("SELECT (%s) FROM Instancia_Mundo where ID_PC = (%s);", sala, ID_PC)
            encontro = cur.fetchall()
            if encontro:
                encotro_handler(encontro)
        if x == 4:
            sala = 'd' + str(y)
            cur.execute("SELECT (%s) FROM Instancia_Mundo where ID_PC = (%s);", sala, ID_PC)
            encontro = cur.fetchall()
            if encontro:
                encotro_handler(encontro)
        '''
              
        
        cur.execute('UPDATE posicao SET x = (%s), y = (%s) WHERE id_personagem = 1',(x, y))
        connection.commit()
        print_location()

def player_examine(action):
    if zonemap[myPlayer. location][SOLVED]:
        print("Zone exausted.")
    else:
        print('')

def start_game():
    return


def main_game_loop():
    while myPlayer.game_over is False:
        prompt()
# here handle if puzzles have been solved, boss defeated, explored everything, etc.
def setup_game():
    personagem_handler()
        
    #os.system('clear')
    print("")
    print("# Vamos Começar!! #")
    print("")

    main_game_loop()


def personagem_handler():
    # Verifica se a tabela pc está vazia
    cur.execute("SELECT COUNT(*) FROM pc;")
    pc_count = cur.fetchone()[0]

    if pc_count == 0:
        print("Não há personagens jogáveis criados. Por favor, crie um novo personagem.")
        nome_personagem = input('Qual o nome do seu personagem?')
        nome_escolhido,vida_atual_escolhida,mana_atual_escolhida, ID_PC = criar_personagem_jogavel(connection,nome_personagem)
        mundo_handler()
        set_posicao_personagem_criado(connection,ID_PC,ID_M)
    else:
        print("Já existem alguns personagens, deseja escolher algum?")
        # Recupera os personagens existentes e suas respectivas vidas e manas atuais
        cur.execute("""
            SELECT personagem.nome, instancia_pc.vidaAtual, instancia_pc.manaAtual, pc.id_pc
            FROM personagem
            JOIN pc ON personagem.id_p = pc.id_personagem
            JOIN instancia_pc ON pc.id_pc = instancia_pc.id_pc;
        """)
        personagens = cur.fetchall()

        print("Personagens disponíveis:")
        for idx, (nome, vida_atual, mana_atual, id_pc) in enumerate(personagens, start=1):
            print(f"{idx}. Nome: {nome}, Vida Atual: {vida_atual}, Mana Atual: {mana_atual}, ID_PC: {id_pc}")

        # Pergunta ao jogador qual personagem ele deseja usar
        escolha = input("Digite o número do personagem que você deseja utilizar ou '0' para criar um novo personagem: ")

        if escolha == '0':
            print("Criando um novo personagem...")
            nome_personagem = input('Qual o nome do seu personagem?')
            nome_escolhido,vida_atual_escolhida,mana_atual_escolhida, ID_PC = criar_personagem_jogavel(connection,nome_personagem)
            mundo_handler()
            set_posicao_personagem_criado(connection,ID_PC,ID_M)
        else:
            try:
                escolha = int(escolha)
                if 1 <= escolha <= len(personagens):
                    personagem_escolhido = personagens[escolha-1]
                    nome_escolhido, vida_atual_escolhida, mana_atual_escolhida, ID_PC = personagem_escolhido
                    
                else:
                    print("Escolha inválida. Tente novamente.")
            except ValueError:
                print("Entrada inválida. Por favor, insira um número.")



def mundo_handler():
    global ID_M

    print("Para que exista um novo personagem, é necessario um novo mundo, portanto é necessario criar um!")
    nome_mundo = input("Digite o nome do mundo: ")
    tamanho_mundo = input("Escolha o tamanho do mundo (Pequeno, Medio, Grande): ")
    while tamanho_mundo not in ["Pequeno", "Medio", "Grande"]:
        print("Tamanho inválido.")
        tamanho_mundo = input("Escolha o tamanho do mundo (Pequeno, Medio, Grande): ")
    
    dificuldade_mundo = input("Escolha a dificuldade (Jornada, Normal, Expert, Master): ")
    while dificuldade_mundo not in ['Jornada', 'Normal', 'Expert', 'Master']:
        print("Dificuldade inválida.")
        dificuldade_mundo = input("Escolha a dificuldade (Jornada, Normal, Expert, Master): ")
    
    # Criar um novo mundo com os valores fornecidos
    ID_M = criar_mundo(connection, nome_mundo, tamanho_mundo, dificuldade_mundo)
    #mundo_criado = criar_mundo(connection, nome_mundo, tamanho_mundo, dificuldade_mundo)
    #print(f"Mundo criado: {mundo_criado}")


title_screen()










'''
else:
        print("Já existem alguns mundos criados, deseja escolher algum?")
        # Recupera os personagens existentes e suas respectivas vidas e manas atuais
        cur.execute("SELECT id_mundo, Nome, Tamanho, Dificuldade FROM Mundo;")
        mundos = cur.fetchall()

        # Caso existam mundos, listar os mundos com índices
        print("Mundos existentes:")
        for index, mundo in enumerate(mundos, start=1):
            print(f"{index}. Nome: {mundo[1]}. Tamanho: {mundo[2]}. Dificuldade: {mundo[3]}")

        # Perguntar ao usuário se deseja criar um novo ou escolher um existente
        escolha = input(f"Escolha o índice do mundo (ou 0 para criar um novo): ")

        try:
            escolha = int(escolha)

            if escolha == 0:
                # Criar um novo mundo
                nome_mundo = input("Digite o nome do mundo: ")
                tamanho_mundo = input("Escolha o tamanho do mundo (Pequeno, Medio, Grande): ")
                while tamanho_mundo not in ["Pequeno", "Medio", "Grande"]:
                    print("Tamanho inválido.")
                    tamanho_mundo = input("Escolha o tamanho do mundo (Pequeno, Medio, Grande): ")

                dificuldade_mundo = input("Escolha a dificuldade (Jornada, Normal, Expert, Master): ")
                while dificuldade_mundo not in ['Jornada', 'Normal', 'Expert', 'Master']:
                    print("Dificuldade inválida.")
                    dificuldade_mundo = input("Escolha a dificuldade (Jornada, Normal, Expert, Master): ")

                ID_M = criar_mundo(connection, nome_mundo, tamanho_mundo, dificuldade_mundo)
                print(ID_M)
                #mundo_criado = criar_mundo(connection, nome_mundo, tamanho_mundo, dificuldade_mundo)
                #print(f"Mundo criado: {mundo_criado}")

            elif 1 <= escolha <= len(mundos):
                # Puxar os atributos do mundo escolhido por índice
                mundo_escolhido = mundos[escolha - 1]
                id_mundo = mundo_escolhido[0]
                ID_M = id_mundo

                print(ID_M)

                cur.execute("SELECT * FROM Mundo WHERE ID_Mundo = %s;", (id_mundo,))
                mundo_selecionado = cur.fetchone()

                if mundo_selecionado:
                    nome_mundo, tamanho_mundo, semente_mundo, dificuldade_mundo, clima_mundo, hora_do_dia_mundo = mundo_selecionado[1:]
                    print(f"Mundo escolhido: Nome={nome_mundo}, Tamanho={tamanho_mundo}, Semente={semente_mundo}, Dificuldade={dificuldade_mundo}, Clima={clima_mundo}, Hora do Dia={hora_do_dia_mundo}")
                else:
                    print("Mundo não encontrado.")
            else:
                print("Índice inválido.")

        except ValueError:
            print("Entrada inválida. Digite um número.")
'''