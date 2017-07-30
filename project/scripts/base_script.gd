extends Node

const dice_scene = preload("res://node_scenes/dice.tscn")
const image1 = preload("res://assets/dice1.png");
const image2 = preload("res://assets/dice2.png");
const image3 = preload("res://assets/dice3.png");
const image4 = preload("res://assets/dice4.png");
const image5 = preload("res://assets/dice5.png");
const image6 = preload("res://assets/dice6.png");
const rounds = 20
const ai_wait_time = 2
const ai_area1 = Vector2(240,250)
const ai_area2 = Vector2(240,346)
const ai_area3 = Vector2(240,442)
const ai_area4 = Vector2(240,538)
const c_approval_gain = 6
const c_approval_cost = 1
const c_military_gain = 2
const c_military_cost = 10
const c_food_gain = 8
const c_food_cost = 10
const c_saboteur_gain = -30
const c_saboteur_cost = 5
var ai_players = global.ai_players
var lost_players = []
var round_num = 1
var fam_step = 1
var roll1 = 0
var roll2 = 0
var roll3 = 0
var roll4 = 0
var roll5 = 0
var roll6 = 0
var dice1
var dice2
var dice3
var dice4
var dice5
var dice6
var fam1_points = 500
var fam1_sabotage = 0
var fam2_points = 500
var fam2_sabotage = 0
var fam3_points = 500
var fam3_sabotage = 0
var fam4_points = 500
var fam4_sabotage = 0
var approval_points = 0
var military_points = 0
var food_points = 0
var saboteurs_points = 0
var p1_approval_gain = c_approval_gain
var p1_approval_cost = c_approval_cost
var p1_military_gain = c_military_gain
var p1_military_cost = c_military_cost
var p1_food_gain = c_food_gain
var p1_food_cost = c_food_cost
var p1_saboteur_gain = c_saboteur_gain
var p1_saboteur_cost = c_saboteur_cost
var p2_approval_gain = c_approval_gain
var p2_approval_cost = c_approval_cost
var p2_military_gain = c_military_gain
var p2_military_cost = c_military_cost
var p2_food_gain = c_food_gain
var p2_food_cost = c_food_cost
var p2_saboteur_gain = c_saboteur_gain
var p2_saboteur_cost = c_saboteur_cost
var p3_approval_gain = c_approval_gain
var p3_approval_cost = c_approval_cost
var p3_military_gain = c_military_gain
var p3_military_cost = c_military_cost
var p3_food_gain = c_food_gain
var p3_food_cost = c_food_cost
var p3_saboteur_gain = c_saboteur_gain
var p3_saboteur_cost = c_saboteur_cost
var p4_approval_gain = c_approval_gain
var p4_approval_cost = c_approval_cost
var p4_military_gain = c_military_gain
var p4_military_cost = c_military_cost
var p4_food_gain = c_food_gain
var p4_food_cost = c_food_cost
var p4_saboteur_gain = c_saboteur_gain
var p4_saboteur_cost = c_saboteur_cost
var approval_gain = c_approval_gain
var approval_cost = c_approval_cost
var military_gain = c_military_gain
var military_cost = c_military_cost
var food_gain = c_food_gain
var food_cost = c_food_cost
var saboteur_gain = c_saboteur_gain
var saboteur_cost = c_saboteur_cost


func _ready():
	randomize()
	set_fixed_process(true)
	set_process_input(true)
	populate_distribution()
	populate_points()
	populate_item_list()

func populate_points():
	get_node("stats/points1").set_text(str(fam1_points))
	get_node("stats/points2").set_text(str(fam2_points))
	get_node("stats/points3").set_text(str(fam3_points))
	get_node("stats/points4").set_text(str(fam4_points))

func populate_item_list():
	var player_list = get_node("distribution/player_list")
	player_list.add_item(" P1 - Gillfield")
	player_list.add_item(" P2 - Heltook")
	player_list.add_item(" P3 - Augustham")
	player_list.add_item(" P4 - Rainmere")

func _fixed_process(delta):
	update_area_values()

func _input(event):
	pass

func update_area_values():
	var approval_dice = get_node("dices/areas/approval_area").get_overlapping_bodies()
	approval_points = 0
	for dice in approval_dice:
		approval_points += dice.value
	var total = approval_points * approval_gain
	get_node("distribution/res_value1").set_text(str(approval_points))
	get_node("distribution/res_total1").set_text(str(total))
	
	var military_dice = get_node("dices/areas/military_area").get_overlapping_bodies()
	military_points = 0
	for dice in military_dice:
		military_points += dice.value
	var total = int(military_points/military_cost)
	get_node("distribution/res_value2").set_text(str(military_points))
	get_node("distribution/res_total2").set_text(str(total))
	
	var food_dice = get_node("dices/areas/food_area").get_overlapping_bodies()
	food_points = 0
	for dice in food_dice:
		food_points += dice.value
	var total = int(food_points/food_cost)
	get_node("distribution/res_value3").set_text(str(food_points))
	get_node("distribution/res_total3").set_text(str(total))
	
	var saboteurs_dice = get_node("dices/areas/saboteurs_area").get_overlapping_bodies()
	saboteurs_points = 0
	for dice in saboteurs_dice:
		saboteurs_points += dice.value
	var total_num = int(saboteurs_points/saboteur_cost)
	var total_power = total_num * saboteur_gain
	get_node("distribution/res_value4").set_text(str(saboteurs_points))
	get_node("distribution/res_total4").set_text(str(total_power))

func _on_roll_button_pressed():
	roll1 = randi()%6+1
	get_node("roll/result1").set_text(str(roll1))
	roll2 = randi()%6+1
	get_node("roll/result2").set_text(str(roll2))
	roll3 = randi()%6+1
	get_node("roll/result3").set_text(str(roll3))
	roll4 = randi()%6+1
	get_node("roll/result4").set_text(str(roll4))
	roll5 = randi()%6+1
	get_node("roll/result5").set_text(str(roll5))
	roll6 = randi()%6+1
	get_node("roll/result6").set_text(str(roll6))
	var total = roll1+roll2+roll3+roll4+roll5+roll6
	get_node("roll/result_total").set_text(str(total))
	
	get_node("roll/roll_button").set_disabled(true)
	
	dice1 = dice_scene.instance()
	dice1.set_pos(Vector2(511, 440))
	get_node("dices/all_dice").add_child(dice1)
	set_dice_image(dice1, roll1)
	dice1.value = roll1
	
	dice2 = dice_scene.instance()
	dice2.set_pos(Vector2(559, 440))
	get_node("dices/all_dice").add_child(dice2)
	set_dice_image(dice2, roll2)
	dice2.value = roll2
	
	dice3 = dice_scene.instance()
	dice3.set_pos(Vector2(607, 440))
	get_node("dices/all_dice").add_child(dice3)
	set_dice_image(dice3, roll3)
	dice3.value = roll3
	
	dice4 = dice_scene.instance()
	dice4.set_pos(Vector2(655, 440))
	get_node("dices/all_dice").add_child(dice4)
	set_dice_image(dice4, roll4)
	dice4.value = roll4
	
	dice5 = dice_scene.instance()
	dice5.set_pos(Vector2(703, 440))
	get_node("dices/all_dice").add_child(dice5)
	set_dice_image(dice5, roll5)
	dice5.value = roll5
	
	dice6 = dice_scene.instance()
	dice6.set_pos(Vector2(751, 440))
	get_node("dices/all_dice").add_child(dice6)
	set_dice_image(dice6, roll6)
	dice6.value = roll6

func set_dice_image(dice, index):
	var image
	if index == 1:
		image = image1
	elif index == 2:
		image = image2
	elif index == 3:
		image = image3
	elif index == 4:
		image = image4
	elif index == 5:
		image = image5
	elif index == 6:
		image = image6
	dice.get_child(0).set_texture(image)

func reset_rolls():
	roll1 = 0
	get_node("roll/result1").set_text(str(roll1))
	roll2 = 0
	get_node("roll/result2").set_text(str(roll2))
	roll3 = 0
	get_node("roll/result3").set_text(str(roll3))
	roll4 = 0
	get_node("roll/result4").set_text(str(roll4))
	roll5 = 0
	get_node("roll/result5").set_text(str(roll5))
	roll6 = 0
	get_node("roll/result6").set_text(str(roll6))
	
	var dices_node = get_node("dices/all_dice")
	for i in range(0, dices_node.get_child_count()):
		dices_node.get_child(i).queue_free()
	
	get_node("roll/roll_button").set_disabled(false)

func _on_apply_button_pressed():
	apply_points()
	prepare_next_round()

func prepare_next_round():
	if lost_players.size() < 3:
		var skip = true
		while skip:
			if fam_step < 4:
				fam_step += 1
			else:
				round_num += 1
				fam_step = 1
			if !lost_players.has(fam_step):
				skip = false
		
		reset_rolls()
		get_node("rounds/round_value").set_text(str(round_num))
		get_node("rounds/player_value").set_text(str(fam_step))
		populate_distribution()
		
		if ai_players.has(fam_step):
			ai_turn()
	else:
		round_num = rounds
	
	if round_num == rounds:
		# game over
		ai_players.clear()
		get_node("rounds/apply_button").set_disabled(true)
		game_over()
	
#	if ai_players.has(fam_step):
#		prepare_next_round()

func check_player_over():
	if fam_step == 1:
		return fam1_points <= 0
	elif fam_step == 2:
		return fam2_points <= 0
	elif fam_step == 3:
		return fam3_points <= 0
	elif fam_step == 4:
		return fam4_points <= 0

func ai_turn():
	get_node("rounds/apply_button").set_disabled(true)
#	print("in ai: " + str(fam_step))
	# wait
	var t = Timer.new()
	t.set_wait_time(ai_wait_time/4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	# roll
	_on_roll_button_pressed()
	# wait
	t.set_wait_time(ai_wait_time/2)
	t.start()
	yield(t, "timeout")
	# assign values
	ai_assing_values()
	# wait
	t.set_wait_time(ai_wait_time)
	t.start()
	yield(t, "timeout")
	# apply 
	get_node("rounds/apply_button").set_disabled(false)
	_on_apply_button_pressed()
	

func ai_assing_values():
	var dice_used = []
	var rolls = [roll1, roll2, roll3, roll4, roll5, roll6]
	var all_dice = [dice1, dice2, dice3, dice4, dice5, dice6]
#	print(rolls)
	
	# check doubles/triples
	var search_value = food_cost
	for c in [0,1]:
		if c == 1:
			search_value = saboteur_cost
		
		var search = true
		var tens_found = 0
		
		while search:
			var found = false
			var index1 = null
			var index2 = null
			var index3 = null
			for i in range(rolls.size()):
				if !dice_used.has(i):
#					print("i:"+str(i)+", roll:"+str(rolls[i])+", value:"+str(search_value)+", mod:"+str(rolls[i]%search_value))
					if rolls[i]%search_value == 0:
						index1 = i
						found = true
						break
					else:
						for j in range(rolls.size()):
							if j > i && !dice_used.has(j):
								var sum = rolls[i]+rolls[j]
#								print("j:"+str(j)+", sum:"+str(sum)+", value:"+str(search_value)+", mod:"+str(sum%search_value))
								if sum%search_value == 0:
									index1 = i
									index2 = j
									found = true
									break
								else:
									for k in range(rolls.size()):
										if k > j && !dice_used.has(k):
											var sum = rolls[i]+rolls[j]+rolls[k]
#											print("k:"+str(k)+", sum:"+str(sum)+", value:"+str(search_value)+", mod:"+str(sum%search_value))
											if sum%search_value == 0:
												index1 = i
												index2 = j
												index3 = k
												found = true
												break
									if found:
										break
					if found:
						break
			
			if found:
				tens_found += 1
		#		print(str(index1)+","+str(index2))
				dice_used.append(index1)
				if index2 != null:
					dice_used.append(index2)
				if index3 != null:
					dice_used.append(index3)
				
				var pos
				if c == 1:
					pos = 1
					if saboteur_cost <= c_saboteur_cost/1.25:
						pos = 4
						var player_index = find_top_player(fam_step)
						get_node("distribution/player_list").select(player_index-1,true)
				else:
					pos = 3
					if tens_found > 1 && saboteur_cost >= 2:
						pos = 2
					elif approval_gain >= c_approval_gain*2:
						pos = 1
				
				move_dice(all_dice[index1], pos)
				if index2 != null:
					move_dice(all_dice[index2], pos)
				if index3 != null:
					move_dice(all_dice[index3], pos)
				
			else:
				search = false
		# end while
	# end for
	for i in range(all_dice.size()):
		if !dice_used.has(i):
			move_dice(all_dice[i], 1)
	
#	move_dice(dice1, 3)
#	move_dice(dice2, 3)
#	move_dice(dice3, 3)
#	move_dice(dice4, 3)
#	move_dice(dice5, 3)
#	move_dice(dice6, 3)

func move_dice(dice, pos_index):
	var pos
	if pos_index == 1:
		pos = ai_area1
	elif pos_index == 2:
		pos = ai_area2
	elif pos_index == 3:
		pos = ai_area3
	elif pos_index == 4:
		pos = ai_area4
	dice.set_pos(pos)

func find_top_player(exclude):
	var all_points = [fam1_points, fam2_points, fam3_points, fam4_points]
	var this_max = -100000
	var max_index
	for i in range(all_points.size()):
		if all_points[i]>this_max:
			if (exclude != null && exclude-1 != i) || exclude == null:
				this_max = all_points[i]
				max_index = i
	return max_index + 1

func populate_distribution():
	if fam_step == 1:
		approval_gain = p1_approval_gain
		approval_cost = p1_approval_cost
		military_gain = p1_military_gain
		military_cost = p1_military_cost
		food_gain = p1_food_gain
		food_cost = p1_food_cost
		saboteur_gain = p1_saboteur_gain
		saboteur_cost = p1_saboteur_cost
	elif fam_step == 2:
		approval_gain = p2_approval_gain
		approval_cost = p2_approval_cost
		military_gain = p2_military_gain
		military_cost = p2_military_cost
		food_gain = p2_food_gain
		food_cost = p2_food_cost
		saboteur_gain = p2_saboteur_gain
		saboteur_cost = p2_saboteur_cost
	elif fam_step == 3:
		approval_gain = p3_approval_gain
		approval_cost = p3_approval_cost
		military_gain = p3_military_gain
		military_cost = p3_military_cost
		food_gain = p3_food_gain
		food_cost = p3_food_cost
		saboteur_gain = p3_saboteur_gain
		saboteur_cost = p3_saboteur_cost
	elif fam_step == 4:
		approval_gain = p4_approval_gain
		approval_cost = p4_approval_cost
		military_gain = p4_military_gain
		military_cost = p4_military_cost
		food_gain = p4_food_gain
		food_cost = p4_food_cost
		saboteur_gain = p4_saboteur_gain
		saboteur_cost = p4_saboteur_cost
	
	get_node("distribution/res_cost1").set_text(str(approval_cost))
	get_node("distribution/res_gain1").set_text(str(approval_gain))
	get_node("distribution/res_cost2").set_text(str(military_cost))
	get_node("distribution/res_gain2").set_text(str(military_gain))
	get_node("distribution/res_cost3").set_text(str(food_cost))
	get_node("distribution/res_gain3").set_text(str(food_gain))
	get_node("distribution/res_cost4").set_text(str(saboteur_cost))
	get_node("distribution/res_gain4").set_text(str(saboteur_gain))

func apply_points():
	var points = approval_points * approval_gain + military_points * military_gain + food_points * food_gain
	var sab_points =  int(saboteurs_points/saboteur_cost) * saboteur_gain
	var total_foods = int(food_points/food_cost)
	var total_military = int(military_points/military_cost)
	approval_gain += total_foods
	saboteur_cost -= total_military
	if saboteur_cost < 1: saboteur_cost = 1
	
	var player_list = get_node("distribution/player_list")
	var selected_array = player_list.get_selected_items()
	var player_index = null
	if selected_array.size() > 0:
		player_index = selected_array[0]
	if player_index != null:
		if player_index == 0:
			fam1_points += sab_points
			if fam1_points <=0: lost_players.append(1)
			get_node("stats/points1").set_text(str(fam1_points))
		elif player_index == 1:
			fam2_points += sab_points
			if fam2_points <=0: lost_players.append(2)
			get_node("stats/points2").set_text(str(fam2_points))
		elif player_index == 2:
			fam3_points += sab_points
			if fam3_points <=0: lost_players.append(3)
			get_node("stats/points3").set_text(str(fam3_points))
		elif player_index == 3:
			fam4_points += sab_points
			if fam4_points <=0: lost_players.append(4)
			get_node("stats/points4").set_text(str(fam4_points))
	
	if fam_step == 1:
		fam1_points += points
#		fam2_sabotage += sab_points
#		fam3_sabotage += sab_points
#		fam4_sabotage += sab_points
		p1_approval_gain = approval_gain
		p1_saboteur_cost = saboteur_cost
		get_node("stats/points1").set_text(str(fam1_points))
	elif fam_step == 2:
		fam2_points += points
#		fam1_sabotage += sab_points
#		fam3_sabotage += sab_points
#		fam4_sabotage += sab_points
		p2_approval_gain = approval_gain
		p2_saboteur_cost = saboteur_cost
		get_node("stats/points2").set_text(str(fam2_points))
	elif fam_step == 3:
		fam3_points += points
#		fam1_sabotage += sab_points
#		fam2_sabotage += sab_points
#		fam4_sabotage += sab_points
		p3_approval_gain = approval_gain
		p3_saboteur_cost = saboteur_cost
		get_node("stats/points3").set_text(str(fam3_points))
	elif fam_step == 4:
		fam4_points += points
#		fam1_sabotage += sab_points
#		fam2_sabotage += sab_points
#		fam3_sabotage += sab_points
		p4_approval_gain = approval_gain
		p4_saboteur_cost = saboteur_cost
		get_node("stats/points4").set_text(str(fam4_points))

func calculate_saboteurs():
	fam1_points += fam1_sabotage
	fam1_sabotage = 0
	get_node("stats/points1").set_text(str(fam1_points))
	fam2_points += fam2_sabotage
	fam2_sabotage = 0
	get_node("stats/points2").set_text(str(fam2_points))
	fam3_points += fam3_sabotage
	fam3_sabotage = 0
	get_node("stats/points3").set_text(str(fam3_points))
	fam4_points += fam4_sabotage
	fam4_sabotage = 0
	get_node("stats/points4").set_text(str(fam4_points))
	
func wait(value):
	var t = Timer.new()
	t.set_wait_time(value)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")

func game_over():
	var winner_text
	var winner_index = find_top_player(null)
	if winner_index == 1: winner_text = "P1 - The House of Gillfield"
	elif winner_index == 2: winner_text = "P2 - The House of Heltook"
	elif winner_index == 3: winner_text = "P3 - The House of Augustham"
	elif winner_index == 4: winner_text = "P4 - The House of Rainmere"
	winner_text += " is the most powerful in the land."
	
#	var dialog = get_node("game_over_dialog")
#	dialog.set_text(winner_text + "\n\n Press OK to return to menu")
#	dialog.popup()
	
	var panel = get_node("game_over_panel")
	var message = get_node("game_over_panel/winner_label")
	message.set_text(winner_text)
	panel.popup()

func _on_game_over_dialog_confirmed():
	get_tree().change_scene("res://scenes/menu.tscn")

func _on_back_to_menu_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")
