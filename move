import time,threading

# """``````````fffffff
# ````````ffffff1ff
# ``````ffffffff|ff
# `````fff5-4-3-2ff
# ````ffff|fffff|ff
# ```fff7-6-8-9-10f
# ``ffff|fffff|ffff
# ``ffff14-13-12-11
# ``fffffffffffffff
#
#  * = You, f = Forest, ` = Water"""

class Weapon(object):
    def __init__(self,vname,damage,speed,rarity,value,weight):
        self.vname = vname
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

ssword = Weapon("Steel sword",4,0,"common",10,3)
sdag = Weapon("Steel dagger",2,1,"common",7,1)

loc = 'beg1'
inv = []


locations = {
    "beg1": {
        "description": "You are at the northernmost point in a shaded forest.",
        "exits": {"S": "beg2"},
        "interact": {},
        "items": [sdag.vname],
        "maps": """``````````fffffff
````````ffffff*ff
``````ffffffff|ff
`````fff0-0-0-0ff
````ffff|fffff|ff
```fff0-0-0-0-0ff
``ffff|fffff|ffff
``ffff0-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg2": {
        "description": "You are in a shaded forest.",
        "exits": {"S": "beg10","W": "beg3","N": "beg1"},
        "interact": {},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-0-*ff
````ffff|fffff|ff
```fff0-0-0-0-0ff
``ffff|fffff|ffff
``ffff0-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg3": {
        "description": "You are in a shaded forest.",
        "exits": {"W":"beg4","E": "beg2",},
        "interact": {},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-*-0ff
````ffff|fffff|ff
```fff0-0-0-0-0ff
``ffff|fffff|ffff
``ffff0-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg4": {
        "description": "You are in a shaded forest.",
        "exits": {"W": "beg5", "E": "beg3"},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-*-0-0ff
````ffff|fffff|ff
```fff0-0-0-0-0ff
``ffff|fffff|ffff
``ffff0-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg5": {
        "description": "You are in a shaded forest.",
        "exits": {"S": "beg6", "E": "beg4"},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff*-0-0-0ff
````ffff|fffff|ff
```fff0-0-0-0-0ff
``ffff|fffff|ffff
``ffff0-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg6": {
        "description": "You are in a shaded forest.",
        "exits": {"W": "beg7","N": "beg5", "E": "beg8"},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-0-0ff
````ffff|fffff|ff
```fff0-*-0-0-0ff
``ffff|fffff|ffff
``ffff0-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg7": {
        "description": "You are in a shaded forest.",
        "exits": {"S": "beg14", "E": "beg6"},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-0-0ff
````ffff|fffff|ff
```fff*-0-0-0-0ff
``ffff|fffff|ffff
``ffff0-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg8": {
        "description": "You are in a shaded forest.",
        "exits": {"W": "beg6", "E": "beg9"},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-0-0ff
````ffff|fffff|ff
```fff0-0-*-0-0ff
``ffff|fffff|ffff
``ffff0-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg9": {
        "description": "You are in a shaded forest.",
        "exits": {"S": "beg11","W": "beg8", "E": "beg10"},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-0-0ff
````ffff|fffff|ff
```fff0-0-0-*-0ff
``ffff|fffff|ffff
``ffff0-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg10": {
        "description": "You are in a shaded forest.",
        "exits": {"W": "beg9","N": "beg2"},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-0-0ff
````ffff|fffff|ff
```fff0-0-0-0-*ff
``ffff|fffff|ffff
``ffff0-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg11": {
        "description": "You are in a shaded forest.",
        "exits": {"W": "beg12","N": "beg9"},
        "items": {ssword.vname},
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-0-0ff
````ffff|fffff|ff
```fff0-0-0-0-0ff
``ffff|fffff|ffff
``ffff0-0-0-*ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg12": {
        "description": "You are in a shaded forest.",
        "exits": {"W": "beg13","E": "beg11"},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-0-0ff
````ffff|fffff|ff
```fff0-0-0-0-0ff
``ffff|fffff|ffff
``ffff0-0-*-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg13": {
        "description": "You are in a shaded forest.",
        "exits": {"W": "beg14", "E": "beg12"},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-0-0ff
````ffff|fffff|ff
```fff0-0-0-0-0ff
``ffff|fffff|ffff
``ffff0-*-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
        "beg14": {
        "description": "You are in a shaded forest.",
        "exits": {"N": "beg7", "E": "beg13"},
        "items": [],
        "maps": """``````````fffffff
````````ffffff0ff
``````ffffffff|ff
`````fff0-0-0-0ff
````ffff|fffff|ff
```fff0-0-0-0-0ff
``ffff|fffff|ffff
``ffff*-0-0-0ffff
``fffffffffffffff

 * = You, f = Forest, ` = Water"""},
}





while True:
    availableExits = ", ".join(locations[loc]["exits"].keys())
    availableItems = locations[loc]["items"]
    print(locations[loc]["description"])
    if availableItems != []:
        print("The items here are :",str(availableItems)[2:-2])
    command = input("Available exits are " + availableExits + " \n".upper())
    if command == "map":
        print(locations[loc]["maps"])
    if command in locations[loc]["exits"]:
        loc = locations[loc]["exits"][command]
    if command == "look":
        ""
    if command == "get "+str(availableItems)[2:-2]:
        print("You pick up "+str(availableItems)[2:-2])
        inv.append(availableItems)
    if command == "inv":
        print("You currently have " +str(inv)+" in your inventory.")
