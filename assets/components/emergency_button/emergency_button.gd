extends Node3D

@onready var timer: Timer = %Timer
@onready var cover_animation: AnimationPlayer = $DropCover

signal emergency_btn_clicked

var is_covered:bool = true
var mouse_in_cover:bool = false
var mouse_in_btn:bool = false

var cover_delay:int = 2	# The time it takes for the cover to reset


func activate() -> void:
	if !cover_animation.is_playing():
		emergency_btn_clicked.emit()
		cover_animation.play("push_btn")
	
	print("Emergency clicked")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if mouse_in_cover and Input.is_action_just_pressed("click"):
		move_cover()
		
	if mouse_in_btn and Input.is_action_just_pressed("click"):
		activate()
		
func move_cover() -> void:
	if is_covered:
		# Play cover animation
		cover_animation.play("open_cover")
		timer.wait_time = cover_delay
		timer.start()
		
		is_covered = false

func _on_button_case_mouse_entered() -> void:
	mouse_in_cover = true

func _on_button_case_mouse_exited() -> void:
	mouse_in_cover = false


func _on_timer_timeout() -> void:
#	reverse the cover animation
	cover_animation.play_backwards("open_cover")
	is_covered = true

# TODO: Maybe use this instead for a more polished look
#func _on_drop_cover_animation_finished(anim_name: StringName) -> void:
	#
	#
	#pass # Replace with function body.


func _on_button_mouse_entered() -> void:
	mouse_in_btn = true


func _on_button_mouse_exited() -> void:
	mouse_in_btn = false
