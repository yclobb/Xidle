extends TextureButton
var highestroll: int = Engine.get_meta("biggestroll", 0)
@onready var enemyhealthbar = $ProgressBar
@onready var atktimer = $Timer
var rollmult: float = Engine.get_meta("rollmultupgrade", 1.0)
var bonusesdegree: int =  0
var tempbonusesdegree: int = 0
var enemyhealth: float = 25
var damage: int = 0
var goldmult: float = Engine.get_meta("goldmult", 1.0)
var bonusesapplied: Array[int] = [0, 0, 0, 0]
var dmgadd: float = Engine.get_meta("dmgadd", 0)
var dmgmult = 1

func _bonus_factor(degree: int) -> float:
	match degree:
		1:
			return 1.1
		2:
			return 1.25
		3:
			return 1.5
		4:
			return 2
		_:
			return 1.0
			
func _gold_factor(degree: int) -> float:
	match degree:
		1:
			return 1.0
		2:
			return 1.0
		3:
			return 1.0
		4:
			return 1.5
		_:
			return 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemyhealthbar.value = enemyhealth
	atktimer.wait_time = 1.0
	atktimer.one_shot = true
	atktimer.stop()
	disabled = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	highestroll = Engine.get_meta("biggestroll", 0)
	if highestroll > 1:
		damage = int(floor(log(highestroll)))
	else:
		damage = 0
	enemyhealthbar.value = enemyhealth
	if enemyhealth > 0 and enemyhealth <= 25:
		enemyhealth += 5*delta
		if enemyhealth >= 25:
			enemyhealth = 25
func _on_pressed() -> void:
	tempbonusesdegree = 0
	if disabled:
		return
	disabled = true
	if atktimer.is_stopped():
		atktimer.start()
	enemyhealth -= damage + dmgadd
	enemyhealthbar.value = enemyhealth
	if enemyhealth <= 0:
		atktimer.stop()
		var randfloat: float = randf()
		if randfloat < 0.5:
			tempbonusesdegree = 1
			if randfloat < 0.25:
				tempbonusesdegree = 2
				if randfloat < 0.1:
					tempbonusesdegree = 3
					if randfloat < 0.02:
						tempbonusesdegree = 4 
		if tempbonusesdegree > bonusesdegree:
			var oldbonusfactor = _bonus_factor(bonusesdegree)
			var newbonusfactor = _bonus_factor(tempbonusesdegree)
			var oldgoldfactor = _gold_factor(bonusesdegree)
			var newgoldfactor = _gold_factor(tempbonusesdegree)
			if bonusesdegree > 0 and oldbonusfactor != 0 and oldgoldfactor != 0:
				rollmult = rollmult / oldbonusfactor
				goldmult = goldmult / oldgoldfactor
			rollmult *= newbonusfactor
			goldmult *= newgoldfactor
			bonusesdegree = tempbonusesdegree
			bonusesapplied = [0, 0, 0, 0]
			bonusesapplied[bonusesdegree - 1] = 1
			Engine.set_meta("rollmultupgrade", rollmult)
			Engine.set_meta("goldmult", goldmult)
			match bonusesdegree:
				1:
					$InfoButtonEnemy1/RichTextLabel.text = "Drops:\n[color=blue]1/2: 1.1x to DP[/color]\n1/4: 1.25x to DP\n1/10: 1.5x to DP\n1/50: 2x to DP and 1.5x to Gold"
				2:
					$InfoButtonEnemy1/RichTextLabel.text = "Drops:\n1/2: 1.1x to DP\n[color=blue]1/4: 1.25x to DP[/color]\n1/10: 1.5x to DP\n1/50: 2x to DP and 1.5x to Gold"
				3:
					$InfoButtonEnemy1/RichTextLabel.text = "Drops:\n1/2: 1.1x to DP\n1/4: 1.25x to DP\n[color=blue]1/10: 1.5x to DP[/color]\n1/50: 2x to DP and 1.5x to Gold"
				4:
					$InfoButtonEnemy1/RichTextLabel.text = "Drops:\n1/2: 1.1x to DP\n1/4: 1.25x to DP\n1/10: 1.5x to DP\n[color=blue]1/50: 2x to DP and 1.5x to Gold[/color]"
					Engine.set_meta("goldmult", goldmult)
		await get_tree().create_timer(0.25).timeout
		enemyhealth = 25	
		disabled = false
		enemyhealthbar.value = enemyhealth	
func _on_timer_timeout() -> void:
	atktimer.stop()
	disabled = false
