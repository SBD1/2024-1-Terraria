import cmd
import sys
import os
import time
import random
import psycopg2

connection = psycopg2.connect(
    dbname="polls",
    user="postgres",
    password="Postgres2021!",
    host="localhost",
    port="5432"
)

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
    os.system('clear')
    print('############################')
    print('# Welcome to the Text RPG! #')
    print('############################')
    print('- Play -')
    print('- Help -')
    print('- Quit -')
    print(teste[0][0])

    title_screen_selections()
    
def help_menu():
    print('# Welcome to the Text RPG!') 
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
        RIGHT: '23'
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
    if destination == "":
        print("Cant go any futher in this direction!")
    else:
        print("\n" + "You have moved to the " + destination + ".")
        myPlayer. location = destination
        x = int(destination[0])
        y = int(destination[1])
        print(x, y)
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
    ### NAME COLLECT
    question1 = "Hello, what's your name?\n"
    for character in question1:
        sys.stdout.write(character)
        sys.stdout.flush()
        time.sleep(0.05)
    player_name = input(">")
    myPlayer.name = player_name


    ### JOB HANDLING
    question2 = "what role do you want to play?\n"
    question2added = "(You can play as a warrior, priest, or mage) \n" 
    for character in question2:
        sys.stdout.write(character)
        sys.stdout.flush()
        time.sleep(0.05)
    for character in question2added:   
        sys.stdout.write(character) 
        sys.stdout.flush()
        time.sleep(0.01)
    player_job = input(">")
    valid_jobs = ['warrior', 'mage', 'priest'] 
    if player_job.lower() in valid_jobs:
        myPlayer.job = player_job
        print("You are now a " + player_job + "!\n") 
    while player_job.lower() not in valid_jobs:
        player_job = input(">")
        if player_job.lower() in valid_jobs:
            myPlayer.job = player_job


            print("You are now a " + player_job + "'!\n")
    #### PLAYER STATS
    if myPlayer.job == 'warrior':
        myPlayer.hp=120
        myPlayer.mp = 20
    elif myPlayer.job == 'mage':
        myPlayer.hp = 40
        myPlayer.mp = 120
    elif myPlayer.job == 'priest':
        myPlayer.hp = 60
        myPlayer.mp = 60

    
    ### INTRODUCTION
    question3 = "Welcome," + player_name + " the " + player_job + ".\n" 
    for character in question3:
        sys.stdout.write(character)
        sys.stdout.flush()
        time.sleep(0.05)
    


    speech1 = "Welcome to this fantasy world!"
    speech2 = "I hope it greets you well!"
    speech3 = "Just make sure you don't get too lost..."
    speech4 = "Heheheh..."
    for character in speech1:
        sys.stdout.write(character) 
        sys.stdout.flush()
        time.sleep(0.03)
    for character in speech2:
        sys.stdout.write(character) 
        sys.stdout.flush() 
        time.sleep(0.03)
    for character in speech3: 
        sys.stdout.write(character) 
        sys.stdout.flush()
        time.sleep(0.1)
    for character in speech4: 
        sys.stdout.write(character) 
        sys.stdout.flush()
        time.sleep(0.2)

    os.system('clear')
    print("##############")
    print("# Let's start now! #")
    print("##############")

    main_game_loop()



title_screen()

