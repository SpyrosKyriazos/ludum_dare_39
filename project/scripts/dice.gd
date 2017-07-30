extends RigidBody2D

export var value = 0
var draging = false
var clicked = false

func _ready():
	randomize()
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	if draging:
		var m_pos = get_viewport().get_mouse_pos()
		set_pos(m_pos)

func _input(event):
	var m_pos = get_viewport().get_mouse_pos()
	var over = m_pos.distance_to(get_pos()) < 20
	if event.type == InputEvent.MOUSE_BUTTON && event.button_index == BUTTON_LEFT && event.is_pressed() && !draging && over:
		clicked = true
	if event.type == InputEvent.MOUSE_MOTION && clicked:
		draging = true
		clicked = false
	if event.type == InputEvent.MOUSE_BUTTON && event.button_index == BUTTON_LEFT && !event.is_pressed() && draging:
		draging = false