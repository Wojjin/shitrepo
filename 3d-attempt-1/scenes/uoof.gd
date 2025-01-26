extends Node3D

@onready var hp = 10
@onready var max_hp = 10
@onready var damage = 2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("damagecalc"):
		body.damagecalc(damage)
	
