extends Node

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	populate_item_lists()

func populate_item_lists():
	var list1 = get_node("option1/option_button1")
	list1.add_item("Player")
	list1.add_item("Computer")
	list1.select(0)
	
	var list2 = get_node("option2/option_button1")
	list2.add_item("Player")
	list2.add_item("Computer")
	list2.select(1)
	
	var list3 = get_node("option3/option_button1")
	list3.add_item("Player")
	list3.add_item("Computer")
	list3.select(1)
	
	var list4 = get_node("option4/option_button1")
	list4.add_item("Player")
	list4.add_item("Computer")
	list4.select(1)

func _on_button_start_pressed():
	get_node("audio/fx_player").play("write_effect")
	var t = Timer.new()
	t.set_wait_time(0.11)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	global.ai_players.clear()
	var option1 = get_node("option1/option_button1").get_selected()
	if option1 == 1: global.ai_players.append(1)
	var option2 = get_node("option2/option_button1").get_selected()
	if option2 == 1: global.ai_players.append(2)
	var option3 = get_node("option3/option_button1").get_selected()
	if option3 == 1: global.ai_players.append(3)
	var option4 = get_node("option4/option_button1").get_selected()
	if option4 == 1: global.ai_players.append(4)
	get_tree().change_scene("res://scenes/game_root.tscn")
