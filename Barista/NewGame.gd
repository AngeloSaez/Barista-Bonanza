extends Button

func _on_button_pressed(): 
	get_tree().change_scene_to_file("res://Level1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#get_parent_control()
	pass
	
