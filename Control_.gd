extends Control

#var simultaneous_scene = preload("res://Levels/Level1.tscn").instantiate()

#func _on_button_pressed(): 
	#get_tree().root.add_child(simultaneous_scene)

# Called when the node enters the scene tree for the first time.
func _ready():
	#self.pressed.connect(_on_button_pressed)
	pass

# Called every frasme. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
