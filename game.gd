extends Node2D

# Player
@onready var player2d = $CharacterBody2D/Sprite2D



var light = true
# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.max_fps = 60
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("light"):
		if light:
			player2d.animation = "dark-idle"
			light = false
		else:
			player2d.animation = "default"
			light = true
	pass
