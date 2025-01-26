extends CharacterBody3D
@onready var cansprint = false
@onready var maxHP = 10
@onready var currentHP = 10
@onready var heals = 100
@onready var canheal = false
@onready var jumps = 2
@onready var bforce = 1000000
@onready var weapon1 = $"Camera Holder/Weapon Holder/Pistol"
@onready var weapon2 = $"Camera Holder/Weapon Holder/shotgun"
@onready var weapon3 = null
const SPEED = 5.0
const SSPEED = 10
const JUMP_VELOCITY = 5
const maxjumps = 2
 
var current_weapon = 3
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	
func _input(event):
	var pos = get_viewport().get_mouse_position()
	
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(event.relative.x * -0.04))
		
	if event.is_action_pressed("g"):
		heal()
		
	if event.is_action_pressed("t"):
		selfharm()
	if event.is_action_pressed("esc"):
		get_tree().quit()
	if event.is_action_pressed("shft"):
		cansprint = true
	if event.is_action_released("shft"):
		cansprint = false
func weapon_select():
	if Input.is_action_pressed("weapon 1"):
		current_weapon = 1
		
		print(current_weapon)
	elif Input.is_action_pressed("weapon 2"):
			current_weapon = 2
			
			print(current_weapon)
	elif Input.is_action_pressed("weapon 3"):
		current_weapon = 3
		print(current_weapon)
		
	if current_weapon == 1:
		weapon1.visible = true
		weapon1.active = true
	else: 
		weapon1.visible = false
		weapon1.active = false
	if current_weapon == 2:
		weapon2.visible = true
		weapon2.active = true
	else: 
		weapon2.visible = false
		weapon2.active = false
		
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if jumps <= 1 and is_on_floor():
			jumps = maxjumps
			print (jumps)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		
		if jumps > 0:
			velocity.y = JUMP_VELOCITY
			jumps -= 1
			print(jumps)
	if Input.is_action_just_pressed("ui_accept") and not is_on_floor():
		if jumps > 0:
			velocity.y = JUMP_VELOCITY
			jumps -= 1
			print(jumps)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("a", "d", "w", "s")

	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()#
	if cansprint == false:
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	else :
		if direction:
			velocity.x = direction.x * SSPEED
			velocity.z = direction.z * SSPEED
		
		else:
			velocity.x = move_toward(velocity.x, 0, SSPEED)
			velocity.z = move_toward(velocity.z, 0, SSPEED)
	move_and_slide()
	weapon_select()
func damagecalc(amount):
	
		
	if amount >= maxHP:
		print ("HOLY SHIT")
	
	if amount > 0:     
		print("YEOUCH! " , amount, " damage taken")
		currentHP -= amount
		amount = 0
		
	if currentHP < 1:
		amount = 0
		print("you are dead!")
		get_tree().quit()
	
func selfharm():
	damagecalc(1)
	if currentHP > 0:
		print("ow! " , currentHP, " left!")
	
func heal():
	var healed = maxHP - currentHP
	if heals > 0:
		print ("current hp: ", currentHP)
		currentHP = maxHP
		canheal = false
		heals -=1
		print("healed for ",healed," HP!")
		print(heals, " heals left!")
	else:
		
		if heals == 0:
			print("No more healing") 
			canheal= true
		else:
			return
	



func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.has_method("damage"):
		damagecalc (area.damage)
