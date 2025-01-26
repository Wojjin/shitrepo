extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var maxHP = 10
@onready var currentHP = 10
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
func hit(amount):
	
	if amount >= maxHP:
		print ("HOLY SHIT")
	
	if amount > 0:     
		print("YEOUCH! " , amount, " damage taken")
		currentHP -= amount
		amount = 0
		
	if currentHP < 1:
		amount = 0
		print("you are dead!")
		queue_free()

	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
