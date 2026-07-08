extends TextureButton
var highestroll: int = Engine.get_meta("biggestroll", 0)
@onready var enemyhealthbar = $ProgressBar
@onready var atktimer = $Timer
var rollexponent = 1
var bonusesdegree: int =  0
var tempbonusesdegree: int = 0
var enemyhealth: float = 25
var damage: int = 0
var formulamult: float = Engine.get_meta("formulamult", 1.0)
var bonusesapplied: Array[int] = [0, 0, 0, 0]
var dmgadd: float = Engine.get_meta("dmgadd", 0)
var dmgmult: float = Engine.get_meta("dmgmult", 1.0)

func _bonus_factor(degree: int) -> float:
	match degree:
		1:
			return 1.05
		2:
			return 1.07
		3:
			return 1.075
		4:
			return 1.1
		_:
			return 1.0
			
func _formula_factor(degree: int) -> float:
	match degree:
		1:
			return 1.0
		2:
			return 1.0
		3:
			return 1.5
		4:
			return 1.8
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
	var rngpoints = Engine.get_meta("rngscore", 0)
	var shouldshow = rngpoints >= 1
	visible = shouldshow
	disabled = not shouldshow
	if not shouldshow:
		return
	rollexponent = Engine.get_meta("rollexponent", 1.0)
	highestroll = Engine.get_meta("biggestroll", 0)
	dmgmult = Engine.get_meta("dmgmult", 1.0)
	if highestroll > 1:
		damage = int(floor(log(highestroll) / log(maxf(100.0 - pow(6.0, float(Engine.get_meta("formulamult", 1.0))), 2.0))))
	else:
		damage = 0
	enemyhealthbar.value = enemyhealth
	if enemyhealth > 0 and enemyhealth <= 1550:
		enemyhealth += 85 * delta
		if enemyhealth >= 1550:
			enemyhealth = 1550
func _on_pressed() -> void:
	tempbonusesdegree = 0
	if disabled:
		return
	disabled = true
	if atktimer.is_stopped():
		atktimer.start()
	enemyhealth -= pow((damage + dmgadd) * dmgmult, 0.9)
	enemyhealthbar.value = enemyhealth
	if enemyhealth <= 0:
		atktimer.stop()
		var randfloat: float = randf()
		if randfloat < 0.34:
			tempbonusesdegree = 1
			if randfloat < 0.2:
				tempbonusesdegree = 2
				if randfloat < 0.07:
					tempbonusesdegree = 3
					if randfloat < 0.03:
						tempbonusesdegree = 4 
		if tempbonusesdegree > bonusesdegree:
			var oldbonusfactor = _bonus_factor(bonusesdegree)
			var newbonusfactor = _bonus_factor(tempbonusesdegree)
			var oldformulafactor = _formula_factor(bonusesdegree)
			var newformulafactor = _formula_factor(tempbonusesdegree)
			if bonusesdegree > 0 and oldbonusfactor != 0 and oldformulafactor != 0:
				rollexponent = rollexponent / oldbonusfactor
				formulamult = formulamult / oldformulafactor
			rollexponent *= newbonusfactor
			formulamult *= newformulafactor
			bonusesdegree = tempbonusesdegree
			bonusesapplied = [0, 0, 0, 0]
			bonusesapplied[bonusesdegree - 1] = 1
			Engine.set_meta("rollexponent", rollexponent)
			Engine.set_meta("formulamult", formulamult)
			match bonusesdegree:
				1:
					$InfoButtonEnemy1/RichTextLabel.text = "Drops:\n[color=blue]1/2: 1.1x to DP[/color]\n1/4: 1.25x to DP\n1/10: 1.5x to DP\n1/50: 2x to DP and 1.5x to Gold"
				2:
					$InfoButtonEnemy1/RichTextLabel.text = "Drops:\n1/2: 1.1x to DP\n[color=blue]1/4: 1.25x to DP[/color]\n1/10: 1.5x to DP\n1/50: 2x to DP and 1.5x to Gold"
				3:
					$InfoButtonEnemy1/RichTextLabel.text = "Drops:\n1/2: 1.1x to DP\n1/4: 1.25x to DP\n[color=blue]1/10: 1.5x to DP[/color]\n1/50: 2x to DP and 1.5x to Gold"
				4:
					$InfoButtonEnemy1/RichTextLabel.text = "Drops:\n1/2: 1.1x to DP\n1/4: 1.25x to DP\n1/10: 1.5x to DP\n[color=blue]1/50: 2x to DP and 1.5x to Gold[/color]"
					Engine.set_meta("formulamult", formulamult)
		await get_tree().create_timer(0.25).timeout
		enemyhealth = 25	
		disabled = false
		enemyhealthbar.value = enemyhealth	
func _on_timer_timeout() -> void:
	atktimer.stop()
	disabled = false
