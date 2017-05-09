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
balance = True

location = [rat1,rat2] # Enemy list for current location


def strike(target):
        global balance
        for i in location:
            if target in str(i.vname).lower():
                balance = False
                i.health = i.health -wielded[0].damage
                i.hostile = True
                print("You hit ",i.vname," for ",wielded[0].damage," damage.")
                print(("enemy is dead?",i.dead))
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
        if i.hostile == True :
            while i.dead == False:
                print(i.vname," attacks!")
                playerHealth -= i.damage
                time.sleep(4)

c = threading.Thread(target=npcAttack)
print("There are enemies here:",', '.join(rat.vname for rat in location))
while True:
    for i in location:
        if i.hostile == True and i.dead == False:
            try:
                c.start()
            except:
                pass
            if i.dead == True and c.isAlive == True:
                c.join()
        # else:
        #     if c.is_alive() ==True:
        #         c.join()
    if balance == True:
        com = input("20>")
    if "strike" in com:
        target = str(com.split(' ')[1]).lower() # Formatting to find the second word in input, "strike something"
        strike(target)
    if "look" in com:
        print("There are enemies here:",', '.join(rat.vname for rat in location))