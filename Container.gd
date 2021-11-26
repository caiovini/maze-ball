extends Container


onready var timer = get_node("Timer")
onready var timer_text = get_node("TimerText")
var increment_time = 0

func _ready():
	timer.set_wait_time(1)
	timer.start()

func _on_Timer_timeout():
	increment_time += 1
	timer_text.text = "Time: %s secs" % increment_time
