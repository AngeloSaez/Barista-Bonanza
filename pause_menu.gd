extends Control

func _ready():
	hide()

func resume():
	hide()
	get_tree().paused = false

func pause():
	show()
	get_tree().paused = true

func testPause():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	testPause()
