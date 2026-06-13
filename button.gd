extends Button
const dicescene = preload("res://Assets/dice.tscn")
var numb: Array[int] = [0]
var biggestroll: int = 0
var uptree2chanceincrease: float = Engine.get_meta("upgrade2treechanceincrease", 0.0)
var score: int = 0
var minroll: int = 1
var maxroll: int = 6
var gold: float = 0
var rolls: int = 0
var combomult: int = 1
var combolist: Array[int] = []
var scoregain: int = 0
var goldmult: float = 1.0
var lis: Array = []
var uptree7mult: int = 1
var dpboostmult = Engine.get_meta("dpboostmult", 1)
var upgradeboostsmult: int = 1
@onready var totalrollmult: float = Engine.get_meta("totalrollmult", 1)
@onready var dynamicdiceamount: int = Engine.get_meta("diceamount", 1)
@onready var subviewport = get_parent().get_node("SubViewportContainer/SubViewport")
var diceamount = dynamicdiceamount
var wait_time: float = 1.0
var unchangedwaittime: float = wait_time
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	numb = Engine.get_meta("numb", numb) as Array[int]
	diceamount = Engine.get_meta("diceamount", diceamount)
	if diceamount <= 0:
		diceamount = 1
	numb.resize(diceamount)
	Engine.set_meta("numb", numb)
	Engine.set_meta("diceamount", diceamount)

func _process(_delta: float) -> void:
	dpboostmult = Engine.get_meta("dpboostmult", 1)
	lis = Engine.get_meta("upgradeboughtlist", [])
	unchangedwaittime = Engine.get_meta("cooldown", 1.0)
	wait_time = unchangedwaittime + diceamount * 0.5
	$Timer.wait_time = wait_time 
	uptree2chanceincrease = Engine.get_meta("upgrade2treechanceincrease", 0.0)
	dynamicdiceamount = Engine.get_meta("diceamount", 1)
	if diceamount != dynamicdiceamount:
		diceamount = dynamicdiceamount
		numb = Engine.get_meta("numb", numb) as Array[int]
		numb.resize(diceamount)
		Engine.set_meta("numb", numb)
		Engine.set_meta("currentcombo", [combomult])
	score = Engine.get_meta("rollscore", 0)
	totalrollmult = Engine.get_meta("totalrollmult", 1)
	Engine.set_meta("scoregain", scoregain)
	Engine.set_meta("gold", gold)
	goldmult = Engine.get_meta("goldmult", 1.0)

# - current progress - fine tuning formula for roll distribution. 
# new progress - instantiate for dice cloning on click
func _button_pressed() -> void:
	uptree7mult = 1
	var clonedice = dicescene.instantiate()
	clonedice.linear_velocity = Vector3(randf_range(-3.0, 3.0), randf_range(-3.0, 3.0), 0.0)
	clonedice.angular_velocity = Vector3(randf_range(-10.0, 10.0), randf_range(-10.0, 10.0), randf_range(-10.0, 10.0))
	var dicesize = randf_range(0.2, 0.4)
	clonedice.scale = Vector3(dicesize, dicesize, dicesize)
	subviewport.add_child(clonedice)
	var randomx = randf_range(-1.5, 1.5)
	clonedice.position = Vector3(randomx, 4.5, 0.0)
	rolls += 1
	disabled = true
	if $Timer:
		$Timer.start()
	for idx in range(numb.size()):
		for i in range(1, randi_range(5, 7)):
			numb[idx] = int(randi_range(minroll, maxroll))
			await get_tree().create_timer(0.1 - 0.008 * i).timeout
			Engine.set_meta("numb", numb)
			numb[idx] = int(randi_range(minroll, maxroll))
		if numb[idx] != maxroll:
			if randf() < uptree2chanceincrease:
				numb[idx] = int(maxroll)
	combomult = listmultiply(combocalc(numb))
	combolist = combocalc(numb)
	for i in numb:
		if i == int(6):
			gold += 1 * goldmult
			if lis.size() >= 7:	
				uptree7mult *= 10
	Engine.set_meta("currentcombo", combolist)
	Engine.set_meta("numb", numb)
	upgradeboostsmult = uptree7mult * dpboostmult
	score += listmultiply(numb) * combomult * totalrollmult * upgradeboostsmult
	scoregain = listmultiply(numb) * combomult * totalrollmult * upgradeboostsmult
	Engine.set_meta("scoregain", scoregain)
	if scoregain > biggestroll:
		biggestroll = scoregain
	Engine.set_meta("biggestroll", biggestroll)
	Engine.set_meta("rollscore", score)
func combocalc(alis) -> Array[int]:
	var dic = {}
	var totalmultlist: Array[int] = []
	for i in alis:
		if i in dic:
			dic[i] += 1
		else:
			dic[i] = 1
	for i in dic:
		totalmultlist.append(factorial(dic[i]))
	return totalmultlist
func _on_timer_timeout() -> void:
	disabled = false
func factorial (num) -> int:
	var factorialnum: int = 1
	for i in range(num):
		factorialnum *= i + 1
	return factorialnum
func listmultiply(array):
	var total = 1
	for i in array:
		total *= i
	return total


#current game idea: roll num from 1 - 6, range upgradable, points only if number rolled meets certain condition
# upgrades planning
# - 1. UPGRADING MULT OF ROLLS
# - 2. UPGRADING MAX NUMB ON ROLL
# - 3. COMBOS
	# - 2X IN A ROW GIVES X2 SCORE
	# - 3X IN A ROW GIVES X4 SCORE(can be multiplied)
# - 4. PROBABILITY OF MAX NUMB GOES UP SLIGHTLY - WHEN REACH QUITE HIGH PROB THINK OF SOMETHING TO ADD RNG
	 # OK COLOR OF TEXT IS USUALLY GOLD TO REPRESENT RARITY, BUT IT CAN ALSO BE DIAMOND, WHICH GIVES EXPONENT MULT OF 1.1^ BUT HAS TO BE UNLOCKED
# - UPGRADE TREE!!!!!!
	# 1,1 done - Never too Much Mult - increases mult gain from mult upgrade by 0.1 per level, buyable for 5 lvls starting at 300, 800, 1600, 3600, and 6000
	# 1,2 done - Tip the Odds - increases chance of rolling max number by 5% per level, buyable for 5 lvls starting at 500, 1000, 2000, 4000, and 8000
	# 1,3 in progress- Wow thats cool - increases mult by 5x, cost is 5000 
	# 1,4 - Beginners luck, boosts chance of highest number by 1.5x if dp is less than 100k
	# 1,5 - 666 - gain 6x dp if you roll a 6, cost is 6666
# - 5. Card Combination - Mayve
# - 6. Attack thing where you need a ceratin amount of dp do deal a certain amount of damage to an enemy, with stronger enemies being different tiers. 
# - - EACH TIME YOU DEFEAT AN ENEMY, CHANCE TO GET A PERMANENT UPGRADE. 
	
