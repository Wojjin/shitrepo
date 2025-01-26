extends Node3D
@onready var ammo_in_gun = 2
@onready var ammo_max = 2
@onready var ammo_inventory = 200
@onready var active= false
@onready var loaded = true
@onready var damage = 10
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if active:
		if Input.is_action_just_pressed("r"):
			if loaded:
				reload()
		if Input.is_action_just_pressed("lc"):
			if loaded:
				fire()
			
		
	
func reload():
	if ammo_in_gun == ammo_max:
		return
	loaded = false
	var spent_ammo = ammo_max-ammo_in_gun
	
	if ammo_inventory > spent_ammo:
		ammo_inventory-=spent_ammo
		ammo_in_gun = ammo_max
		print(ammo_inventory)
	else:
		if ammo_inventory == 0:
			print("out of ammo")
			loaded = true
			return
		else:
			ammo_in_gun = ammo_inventory
			ammo_inventory = 0
			
	
	$AnimationPlayer.play("loader")
	
func fire():
	
	if ammo_in_gun == 0:
		loaded = false
		reload()
		return
	else:
		loaded = false
		ammo_in_gun -= 1
		$AnimationPlayer.play("fire");
		$GPUParticles3D2.emitting = true
		$GPUParticles3D2.one_shot = true
	
	for ray in $"Raycast carrier".get_children():
		if ray.is_colliding():
				var object= ray.get_collider()
				
				if object.has_method('hit'):
					object.hit(damage)
					print(object)
					
			
			
	
	print(ammo_in_gun)
	
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "loader":
		loaded = true
	if anim_name == "fire":
		loaded= true
	pass # Replace with function body.
