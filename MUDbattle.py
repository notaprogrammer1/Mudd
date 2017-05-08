import time,threading


class Weapon(object):
    def __init__(self,damage,speed,rarity,value,weight):
        self.damage = damage
        self.speed = speed
        self.rarity = rarity
        self.value = value
        self.weight = weight


class NPC(object):
    def __init__(self,vname,health,damage,description, xp, hostile, dead):
        self.vname = vname
        self.health = health
        self.damage = damage
        self.description = description
        self.xp = xp
        self.hostile = False
        self.dead = False


ssword = Weapon(4,0,"common",10,3)
sdagger = Weapon(2,1,"common",7,1)

rat1 = NPC("Young Rat",5,1,"A hissing juvenile rat with dirty, matted fur.",2, False,False)
rat2 = NPC("Adult Rat", 9,3,"A fully grown rat",5,False,False)

bbalance = 3 # will be used as a "base balance" for recovery time.
wielded = [ssword] # Weapon currently wielded. Can be changed to "Wielded1" or "Wielded2" for mainhand/offhand.
playerHealth = 20

location = [rat1,rat2] # Enemy list for current location
balance = True

def strike(target):
        global balance
        for i in location:
            if target in str(i.vname).lower():
                balance = False
                i.health = i.health -wielded[0].damage
                i.hostile = True
                print("You hit ",i.vname," for ",wielded[0].damage," damage.")
                if i.health <= 0:
                    print("You've slain ",i.vname,"!")
                    i.dead = True
                    location.remove(i)
                time.sleep(bbalance)
                balance = True
                print("You have recovered your balance")

def npcAttack():
    global playerHealth
    for i in location:
        if i.dead == False :
            while i.hostile == True:
                print(i.vname," attacks!")
                playerHealth -= i.damage
                time.sleep(3)



while True:
    if location != []:
        c = threading.Thread(target=npcAttack())
        c.start()
        print("There are enemies here:",', '.join(rat.vname for rat in location))
    if balance == True:
        com = input("20>")
        if "strike" in com:
            target = str(com.split(' ')[1]).lower() # Formatting to find the second word in input, "strike something"
            strike(target)


##git testing for branch






















