extends Area2D

onready var ball = get_node("Ball")
onready var wall_maze = get_node("Walls")
onready var victory_text = get_node("VictoryText")
onready var restart_button = get_node("RestartButton")
var walls = []
var is_victory = false

func _ready():
	
	victory_text.visible = false
	restart_button.visible = false
	var data_file = File.new()
	data_file.open("res://map/map.json", File.READ)	
	var data_parse = JSON.parse(data_file.get_as_text())
	data_file.close()

	for coord in data_parse.result:
		walls.append({ "from": Vector2(coord.from.x, coord.from.y), 
						 "to": Vector2(coord.to.x, coord.to.y)})

	for wall in walls:
		var coll_shape = CollisionShape2D.new()
		var shape = RectangleShape2D.new()		

		coll_shape.position = Vector2((wall.from.x+wall.to.x)/2,
								 (wall.from.y+wall.to.y)/2)
		shape.extents = Vector2(5, sqrt(pow(wall.from.x-wall.to.x, 2)+
							pow(wall.from.y-wall.to.y, 2))/2)
							
		coll_shape.set_shape(shape)
		coll_shape.rotation_degrees = -rad2deg(atan2(wall.from.x-
					wall.to.x, wall.from.y-wall.to.y))
		wall_maze.add_child(coll_shape)

func _draw():
	draw_circle(ball.get_position(), 40, Color.bisque)

	for wall in walls:
		draw_line(wall.from, wall.to, Color.whitesmoke, 16)

func _process(delta):
	if !get_overlapping_bodies() and !is_victory:
		update()
	else:
		is_victory = true
		victory_text.visible = true
		restart_button.visible = true

func _on_RestartButton_button_down():
	return get_tree().reload_current_scene()
